[CmdletBinding()]
param(
    [ValidateSet('Network','Identity','Infrastructure','Monitoring','Scenario','All')]
    [string] $Phase = 'All'
)

$root = $PSScriptRoot
function Invoke-NorthstarPhase {
    param([string] $Name,[scriptblock] $Action)
    Write-Host "`n=== Northstar: $Name ===" -ForegroundColor Cyan
    & $Action
}

if ($Phase -in 'Network','All') {
    Invoke-NorthstarPhase 'Network' { & "$root/hyperv/Build-NorthstarNetwork.ps1" }
}
if ($Phase -in 'Identity','All') {
    Write-Host 'Identity phase is intentionally split: run forest promotion interactively with a DSRM password that is not stored in Git.' -ForegroundColor Yellow
}
if ($Phase -in 'Infrastructure','All') {
    Invoke-NorthstarPhase 'Infrastructure' { & "$root/infrastructure/Install-NorthstarSqlWorkload.ps1" }
}
if ($Phase -in 'Monitoring','All') {
    Invoke-NorthstarPhase 'Monitoring fixtures' { & "$root/monitoring/Generate-NorthstarTelemetry.ps1" -Mode Normal }
}
if ($Phase -in 'Scenario','All') {
    Write-Host 'Scenario injection is opt-in. Example: ./incidents/Inject-Northstar-Incident.ps1 -Scenario TelemetryBacklog' -ForegroundColor Yellow
}

Write-Host "`nNorthstar build orchestration complete." -ForegroundColor Green
