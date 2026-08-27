[CmdletBinding()]
param([ValidateSet('Inject','Validate','Recover')][string]$Mode='Validate',[string]$EvidenceRoot=(Join-Path $PSScriptRoot '..\..\evidence'))
$path=Join-Path $EvidenceRoot ('ns-inc-02-'+(Get-Date -Format 'yyyyMMdd-HHmmss')+'.json'); New-Item -ItemType Directory -Force -Path $EvidenceRoot|Out-Null
$result=[ordered]@{Scenario='NS-INC-02';Mode=$Mode;Timestamp=(Get-Date).ToUniversalTime().ToString('o')}
switch($Mode){
 'Inject' {$result.Action='Use only the documented isolated lab fault to simulate a dependency failure; do not alter real credentials, directory objects or external DNS.'}
 'Validate' {$result.Action='Check DC reachability, internal DNS resolution, time sync and AD replication before escalating.'}
 'Recover' {$result.Action='Remove the documented lab fault and validate DNS plus authentication from a synthetic client.'}
}
$result|ConvertTo-Json|Set-Content $path; Write-Host "NS-INC-02 $Mode evidence: $path"