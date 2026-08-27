[CmdletBinding()]
param([ValidateSet('Inject','Validate','Recover')][string]$Mode='Validate',[string]$HealthUrl='http://APP01/health')
$r=[ordered]@{Scenario='NS-INC-04';Mode=$Mode;HealthUrl=$HealthUrl;Timestamp=(Get-Date).ToUniversalTime().ToString('o')}
switch($Mode){
 'Inject' {$r.Action='Use the documented reversible lab application fault; preserve current IIS configuration before changes.'}
 'Validate' {$r.Action='Check DNS, TCP reachability, HTTP health, IIS site/app pool state and downstream dependencies.'}
 'Recover' {$r.Action='Reverse the documented lab fault, restore service, then validate HTTP health and monitoring recovery.'}
}
$r|ConvertTo-Json|Write-Output