[CmdletBinding()]
param([ValidateSet('Inject','Validate','Recover')][string]$Mode='Validate',[int]$ThresholdPercent=85)
$r=[ordered]@{Scenario='NS-INC-05';Mode=$Mode;ThresholdPercent=$ThresholdPercent;Timestamp=(Get-Date).ToUniversalTime().ToString('o')}
switch($Mode){
 'Inject' {$r.Action='Generate only bounded synthetic lab capacity pressure using the documented disposable workload path.'}
 'Validate' {$r.Action='Check capacity trend, largest consumers, service impact and whether alert thresholds are appropriate.'}
 'Recover' {$r.Action='Remove the synthetic workload, confirm capacity recovery and retain trend evidence for RCA.'}
}
$r|ConvertTo-Json|Write-Output