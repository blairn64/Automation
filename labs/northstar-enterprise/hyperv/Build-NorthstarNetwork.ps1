[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Prefix = 'NS',
    [string]$WanSwitch = 'NS-WAN'
)

$ErrorActionPreference = 'Stop'

$Switches = @(
    'NS-CORP-USERS',
    'NS-CORP-SERVERS',
    'NS-INFRA-MGMT',
    'NS-DMZ',
    'NS-PRINT-IOT',
    'NS-MONITORING',
    'NS-OT-PLANT',
    'NS-GUEST'
)

foreach ($switchName in $Switches) {
    if (-not (Get-VMSwitch -Name $switchName -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($switchName, 'Create private Hyper-V switch')) {
            New-VMSwitch -Name $switchName -SwitchType Private | Out-Null
        }
    }
}

Write-Host 'Northstar virtual network created.'
Write-Host 'OPNsense provides routing/firewall policy between zones.'
