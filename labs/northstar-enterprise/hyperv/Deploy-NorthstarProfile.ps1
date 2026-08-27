[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('CORE','CORPORATE','MONITORING','INCIDENT')]
    [string]$Profile = 'CORE',
    [string]$VmRoot = 'D:\HyperV\Northstar',
    [switch]$Start
)

$ErrorActionPreference = 'Stop'

$profiles = @{
    CORE = @('NS-FW01','HQ-DC01','HQ-DC02','HQ-MGMT01')
    CORPORATE = @('NS-FW01','HQ-DC01','HQ-DC02','HQ-MGMT01','HQ-FS01','HQ-PRN01','HQ-SQL01','HQ-APP01','HQ-WEB01')
    MONITORING = @('NS-FW01','HQ-DC01','HQ-MGMT01','NS-ELK01','NS-EA01','NS-ZBX01','NS-GRAF01')
    INCIDENT = @('NS-FW01','HQ-DC01','HQ-DC02','HQ-MGMT01','HQ-FS01','HQ-PRN01','HQ-SQL01','HQ-APP01','HQ-WEB01','NS-ELK01','NS-EA01','NS-ZBX01','NS-GRAF01','HQ-CL01','EAST-OT01')
}

$targets = $profiles[$Profile]

foreach ($name in $targets) {
    $vm = Get-VM -Name $name -ErrorAction SilentlyContinue
    if (-not $vm) {
        Write-Warning "$name does not exist. Provision the VM first."
        continue
    }

    if ($Start -and $vm.State -ne 'Running') {
        if ($PSCmdlet.ShouldProcess($name, 'Start VM')) {
            Start-VM -Name $name
        }
    }
    else {
        Write-Host "$name: $($vm.State)"
    }
}

Write-Host "Northstar profile '$Profile' processed."
