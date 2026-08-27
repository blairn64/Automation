[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$VmRoot,

    [switch]$CreateDirectories,

    [switch]$ValidateSwitches,

    [string[]]$RequiredSwitches = @('NS-MGMT','NS-SERVERS','NS-USERS','NS-TELEMETRY','NS-MONITORING')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$results = [System.Collections.Generic.List[object]]::new()

if ($ValidateSwitches) {
    if (-not (Get-Command Get-VMSwitch -ErrorAction SilentlyContinue)) {
        throw 'Hyper-V PowerShell cmdlets are not available on this host.'
    }
    foreach ($switch in $RequiredSwitches) {
        $exists = [bool](Get-VMSwitch -Name $switch -ErrorAction SilentlyContinue)
        $results.Add([pscustomobject]@{ Type='Switch'; Name=$switch; Status=if($exists){'Present'}else{'Missing'} })
    }
}

$planScript = Join-Path $PSScriptRoot 'New-NorthstarVmPlan.ps1'
if (-not (Test-Path $planScript)) { throw "VM plan script not found: $planScript" }

if ($CreateDirectories) {
    & $planScript -VmRoot $VmRoot -CreateDirectories
}
else {
    & $planScript -VmRoot $VmRoot
}

$results.Add([pscustomobject]@{
    Type='Plan'
    Name='Northstar'
    Status='Generated'
})

$results | Select-Object *, @{Name='TimestampUtc';Expression={(Get-Date).ToUniversalTime().ToString('o')}}
