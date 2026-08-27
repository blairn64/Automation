[CmdletBinding()]
param([ValidateSet('Inject','Validate','Recover')][string]$Mode='Validate',[string]$ComputerName='PRN01')
$e=[ordered]@{Scenario='NS-INC-03';Mode=$Mode;ComputerName=$ComputerName;Timestamp=(Get-Date).ToUniversalTime().ToString('o')}
switch($Mode){
 'Inject' {$e.Action='Use the documented isolated lab queue fault; do not target non-lab printers.'}
 'Validate' {$e.Action='Check host reachability, Print Spooler state, queue status and synthetic print path.'}
 'Recover' {$e.Action='Restore the documented lab queue/service state and submit a synthetic validation job.'}
}
$e|ConvertTo-Json|Write-Output