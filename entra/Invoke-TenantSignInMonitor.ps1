[CmdletBinding()]
param(
    [int]$HoursBack = 24,
    [string[]]$TenantIds = @('YOUR-TENANT-ID-1'),
    [string[]]$AllowedCountries = @('GB','IE'),
    [string]$OutputPath = './output/sign-in-report.html'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HtmlSafe([object]$Value) {
    return [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

function Get-SignInFindings {
    param([string]$TenantId)

    # Authentication is deliberately externalised. In a real lab, use a
    # certificate-backed application registration or delegated auth.
    # Example: Connect-MgGraph -TenantId $TenantId -ClientId $env:GRAPH_CLIENT_ID -CertificateThumbprint $env:GRAPH_CERT_THUMBPRINT
    throw "Connect-MgGraph and the required permissions must be configured in the target lab before querying tenant $TenantId."
}

$start = (Get-Date).ToUniversalTime().AddHours(-$HoursBack)
$findings = [System.Collections.Generic.List[object]]::new()

foreach ($tenantId in $TenantIds) {
    try {
        $records = Get-SignInFindings -TenantId $tenantId
        foreach ($record in $records) {
            if ($record.Location.CountryOrRegion -and $record.Location.CountryOrRegion -notin $AllowedCountries) {
                $findings.Add([pscustomobject]@{
                    Tenant       = $tenantId
                    User         = $record.UserPrincipalName
                    TimeUtc      = $record.CreatedDateTime
                    Country      = $record.Location.CountryOrRegion
                    IPAddress    = $record.IpAddress
                    Result       = 'Successful sign-in outside allowlist'
                })
            }
        }
    }
    catch {
        $findings.Add([pscustomobject]@{
            Tenant       = $tenantId
            User         = 'N/A'
            TimeUtc      = (Get-Date).ToUniversalTime()
            Country      = 'N/A'
            IPAddress    = 'N/A'
            Result       = "Collection error: $($_.Exception.Message)"
        })
    }
}

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

$rows = foreach ($item in $findings) {
    "<tr><td>$(ConvertTo-HtmlSafe $item.Tenant)</td><td>$(ConvertTo-HtmlSafe $item.User)</td><td>$(ConvertTo-HtmlSafe $item.TimeUtc)</td><td>$(ConvertTo-HtmlSafe $item.Country)</td><td>$(ConvertTo-HtmlSafe $item.IPAddress)</td><td>$(ConvertTo-HtmlSafe $item.Result)</td></tr>"
}

$html = @"
<!doctype html>
<html lang="en"><head><meta charset="utf-8"><title>Sign-in Security Report</title>
<style>body{font-family:Arial,sans-serif;margin:2rem;color:#222}table{border-collapse:collapse;width:100%}th,td{border:1px solid #ccc;padding:.5rem;text-align:left}th{background:#eee}</style>
</head><body><h1>Sign-in Security Report</h1>
<p>Window: last $HoursBack hours. Allowed countries: $($AllowedCountries -join ', ').</p>
<table><thead><tr><th>Tenant</th><th>User</th><th>Time (UTC)</th><th>Country</th><th>IP</th><th>Result</th></tr></thead><tbody>
$($rows -join "`n")
</tbody></table></body></html>
"@

Set-Content -Path $OutputPath -Value $html -Encoding UTF8
Write-Output "Report written to $OutputPath"
