[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$TenantIds,

    [int]$HoursBack = 24,

    [string[]]$AllowedCountries = @('GB', 'IE'),

    [string]$OutputPath = './output/sign-in-report.html',

    [string]$ClientId = $env:GRAPH_CLIENT_ID,

    [string]$CertificateThumbprint = $env:GRAPH_CERT_THUMBPRINT
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HtmlSafe {
    param([AllowNull()][object]$Value)
    [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

function Connect-GraphCertificate {
    param([Parameter(Mandatory)][string]$TenantId)

    if ([string]::IsNullOrWhiteSpace($ClientId) -or [string]::IsNullOrWhiteSpace($CertificateThumbprint)) {
        throw 'Set GRAPH_CLIENT_ID and GRAPH_CERT_THUMBPRINT, or pass ClientId and CertificateThumbprint.'
    }

    Disconnect-MgGraph -ErrorAction SilentlyContinue | Out-Null
    Connect-MgGraph -TenantId $TenantId -ClientId $ClientId -CertificateThumbprint $CertificateThumbprint -NoWelcome | Out-Null
}

function Get-SignInFindings {
    param(
        [Parameter(Mandatory)][string]$TenantId,
        [Parameter(Mandatory)][datetime]$StartTime
    )

    Connect-GraphCertificate -TenantId $TenantId

    $filter = "createdDateTime ge $($StartTime.ToUniversalTime().ToString('o'))"
    Get-MgAuditLogSignIn -Filter $filter -All |
        Where-Object {
            $_.Status.ErrorCode -eq 0 -and
            $_.Location.CountryOrRegion -and
            $_.Location.CountryOrRegion -notin $AllowedCountries
        }
}

$start = (Get-Date).ToUniversalTime().AddHours(-$HoursBack)
$findings = [System.Collections.Generic.List[object]]::new()

foreach ($tenantId in $TenantIds) {
    try {
        foreach ($record in (Get-SignInFindings -TenantId $tenantId -StartTime $start)) {
            $findings.Add([pscustomobject]@{
                Tenant    = $tenantId
                User      = $record.UserPrincipalName
                TimeUtc   = $record.CreatedDateTime
                Country   = $record.Location.CountryOrRegion
                IPAddress = $record.IpAddress
                App       = $record.AppDisplayName
                Result    = 'Successful sign-in outside allowlist'
            })
        }
    }
    catch {
        $findings.Add([pscustomobject]@{
            Tenant    = $tenantId
            User      = 'N/A'
            TimeUtc   = (Get-Date).ToUniversalTime()
            Country   = 'N/A'
            IPAddress = 'N/A'
            App       = 'N/A'
            Result    = "Collection error: $($_.Exception.Message)"
        })
    }
}

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$rows = foreach ($item in $findings) {
    "<tr><td>$(ConvertTo-HtmlSafe $item.Tenant)</td><td>$(ConvertTo-HtmlSafe $item.User)</td><td>$(ConvertTo-HtmlSafe $item.TimeUtc)</td><td>$(ConvertTo-HtmlSafe $item.Country)</td><td>$(ConvertTo-HtmlSafe $item.IPAddress)</td><td>$(ConvertTo-HtmlSafe $item.App)</td><td>$(ConvertTo-HtmlSafe $item.Result)</td></tr>"
}

$html = @"
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Sign-in Security Report</title>
<style>body{font-family:system-ui,sans-serif;margin:2rem;color:#222}table{border-collapse:collapse;width:100%}th,td{border:1px solid #ccc;padding:.5rem;text-align:left}th{background:#eee}code{font-family:ui-monospace,monospace}</style>
</head><body><h1>Sign-in Security Report</h1>
<p>Window: last $HoursBack hours. Allowed countries: $(ConvertTo-HtmlSafe ($AllowedCountries -join ', ')).</p>
<table><thead><tr><th>Tenant</th><th>User</th><th>Time (UTC)</th><th>Country</th><th>IP</th><th>Application</th><th>Result</th></tr></thead><tbody>
$($rows -join "`n")
</tbody></table></body></html>
"@

Set-Content -LiteralPath $OutputPath -Value $html -Encoding UTF8
Write-Output "Report written to $OutputPath"
