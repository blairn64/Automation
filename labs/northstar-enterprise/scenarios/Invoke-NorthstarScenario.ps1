[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('TelemetryBacklog','IdentityDns','PrintSpooler')]
    [string]$Scenario,
    [switch]$Execute,
    [switch]$CollectEvidence
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$profiles = Join-Path $root 'hyperv/profiles'
$incidents = Join-Path $root 'incidents'

Write-Host "Northstar scenario: $Scenario"
Write-Host 'Mode:' $(if ($Execute) { 'EXECUTE (controlled lab only)' } else { 'PLAN' })

$profile = switch ($Scenario) {
    'TelemetryBacklog' { 'INCIDENT' }
    'IdentityDns'       { 'INCIDENT' }
    'PrintSpooler'      { 'CORPORATE' }
}

Write-Host "Required VM profile: $profile"
Write-Host "Incident documentation: $incidents"

if (-not $Execute) {
    Write-Host 'No fault injected. Re-run with -Execute only inside the isolated Northstar lab.'
    return
}

switch ($Scenario) {
    'PrintSpooler' {
        Write-Warning 'Controlled action: stopping Print Spooler on the current synthetic lab target.'
        Stop-Service -Name Spooler -ErrorAction Stop
    }
    'IdentityDns' {
        Write-Warning 'Controlled action placeholder: use the documented lab injector on the isolated target; no domain-wide DNS changes are performed here.'
    }
    'TelemetryBacklog' {
        Write-Warning 'Controlled action: use the telemetry fixture generator to create backlog events rather than damaging a live queue.'
    }
}

if ($CollectEvidence) {
    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $out = Join-Path $root "evidence/$Scenario-$stamp.txt"
    New-Item -ItemType Directory -Path (Split-Path $out) -Force | Out-Null
    Get-Date | Out-File $out
    Get-Service | Where-Object Status -ne 'Running' | Format-Table -AutoSize | Out-File $out -Append
    Write-Host "Evidence written to $out"
}
