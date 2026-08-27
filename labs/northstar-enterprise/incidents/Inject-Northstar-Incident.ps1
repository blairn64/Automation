[CmdletBinding()]
param(
    [ValidateSet('TelemetryBacklog','IdentityDns','PrintSpooler')] [string] $Scenario
)

switch ($Scenario) {
    'TelemetryBacklog' {
        & "$PSScriptRoot/../monitoring/Generate-NorthstarTelemetry.ps1" -Mode Backlog -Count 100
        Write-Warning 'Synthetic incident injected: OT telemetry queue backlog.'
    }
    'IdentityDns' {
        Write-Warning 'Synthetic incident marker: identity/DNS degradation. Apply only in an isolated lab.'
        New-Item -ItemType Directory -Path "$PSScriptRoot/fixtures" -Force | Out-Null
        '{"scenario":"IdentityDns","status":"Injected"}' | Set-Content "$PSScriptRoot/fixtures/identity-dns-incident.json"
    }
    'PrintSpooler' {
        Write-Warning 'Synthetic incident marker: print spooler failure simulation.'
        New-Item -ItemType Directory -Path "$PSScriptRoot/fixtures" -Force | Out-Null
        '{"scenario":"PrintSpooler","status":"Injected"}' | Set-Content "$PSScriptRoot/fixtures/print-incident.json"
    }
}
