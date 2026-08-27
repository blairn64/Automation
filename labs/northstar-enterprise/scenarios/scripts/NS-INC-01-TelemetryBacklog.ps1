[CmdletBinding()]
param([ValidateSet('Inject','Validate','Recover')][string]$Mode='Validate',[string]$StatePath=(Join-Path $PSScriptRoot '..\..\evidence\ns-inc-01-state.json'))
New-Item -ItemType Directory -Force -Path (Split-Path $StatePath) | Out-Null
$state=[ordered]@{Scenario='NS-INC-01';Mode=$Mode;Timestamp=(Get-Date).ToUniversalTime().ToString('o');Expected='Queue depth and ingestion freshness return to baseline after consumer recovery'}
switch($Mode){
 'Inject' {$state.Action='Mark controlled telemetry-consumer outage for lab scenario; use the documented lab service control only.'}
 'Validate' {$state.Action='Validate producer, queue, consumer and indexing stages independently.'}
 'Recover' {$state.Action='Restore the documented lab consumer, then confirm queue drain and current indexed events.'}
}
$state | ConvertTo-Json | Set-Content $StatePath
Write-Host "NS-INC-01 $Mode evidence: $StatePath"