[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string[]]$TenantIds,
    [int]$HoursBack = 24,
    [string[]]$AllowedCountries = @('GB', 'IE'),
    [string]$OutputPath = './output/sign-in-report.html',
    [string]$ClientId = $env:GRAPH_CLIENT_ID,
    [string]$CertificateThumbprint = $env:GRAPH_CERT_THUMBPRINT
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HtmlSafe {
    param([AllowNull()] [object]$Value)
    [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

function Connect-ToGraphTenant {
    param(
        [Parameter(Mandatory)] [string]$TenantId,
        [Parameter(Mandatory)] [string]$ClientIdValue,
        [Parameter(Mandatory)] [string]$CertificateThumbprintValue
    )

    if (-not $ClientIdValue) {
        throw 'GRAPH_CLIENT_ID is required (or pass -ClientId).'
    }

    if (-not $CertificateThumbprintValue) {
        throw 'GRAPH_CERT_THUMBPRINT is required (or pass -CertificateThumbprint).'
    }

    Disconnect-MgGraph -ErrorAction SilentlyContinue | Out-Null
    Connect-MgGraph -TenantId $TenantId -ClientId $ClientIdValue -CertificateThumbprint $CertificateThumbprintValue -NoWelcome | Out-Null
}

function Get-SignInFinding {
    param([Parameter(Mandatory)] [string]$TenantId)

    Connect-ToGraphTenant -TenantId $TenantId -ClientIdValue $ClientId -CertificateThumbprintValue $CertificateThumbprint

    $start = (Get-Date).ToUniversalTime().AddHours(-$HoursBack).ToString('o')
    $filter = "createdDateTime ge $start and status/errorCode eq 0"

    Get-MgAuditLogSignIn -Filter $filter -All |
        Where-Object {
            $_.Location.CountryOrRegion -and
            $_.Location.CountryOrRegion -notin $AllowedCountries
        } |
        ForEach-Object {
            [pscustomobject]@{
                Tenant    = $TenantId
                User      = $_.UserPrincipalName
                TimeUtc   = $_.CreatedDateTime
                Country   = $_.Location.CountryOrRegion
                IPAddress = $_.IpAddress
                Result    = 'Successful sign-in outside allowlist'
            }
        }
}

$findings = [System.Collections.Generic.List[object]]::new()

foreach ($tenantId in $TenantIds) {
    try {
        foreach ($record in (Get-SignInFinding -TenantId $tenantId)) {
            $findings.Add($record)
        }
    }
    catch {
        $findings.Add([pscustomobject]@{
            Tenant    = $tenantId
            User      = 'N/A'
            TimeUtc   = (Get-Date).ToUniversalTime()
            Country   = 'N/A'
            IPAddress = 'N/A'
            Result    = "Collection error: $($_.Exception.Message)"
        })
    }
}

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$rows = foreach ($item in $findings) {
    "<tr><td>$(ConvertTo-HtmlSafe $item.Tenant)</td><td>$(ConvertTo-HtmlSafe $item.User)</td><td>$(ConvertTo-HtmlSafe $item.TimeUtc)</td><td>$(ConvertTo-HtmlSafe $item.Country)</td><td>$(ConvertTo-HtmlSafe $item.IPAddress)</td><td>$(ConvertTo-HtmlSafe $item.Result)</td></tr>"
}

$html = @"
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><title>Sign-in Security Report</title></head>
<body>
<h1>Sign-in Security Report</h1>
<p>Window: last $HoursBack hours. Allowed countries: $($AllowedCountries -join ', ').</p>
<table>
<thead><tr><th>Tenant</th><th>User</th><th>Time (UTC)</th><th>Country</th><th>IP</th><th>Result</th></tr></thead>
<tbody>
$($rows -join "`n")
</tbody>
</table>
</body>
</html>
"@

Set-Content -LiteralPath $OutputPath -Value $html -Encoding UTF8
Write-Output "Report written to $OutputPath"
