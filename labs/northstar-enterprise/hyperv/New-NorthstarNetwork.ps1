[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Prefix = 'NS',
    [switch]$RemoveExisting
)

$ErrorActionPreference = 'Stop'

$Switches = @(
    @{ Name = "$Prefix-CORP-USERS"; Notes = 'VLAN 10 Corporate users' },
    @{ Name = "$Prefix-SERVERS"; Notes = 'VLAN 20 Servers' },
    @{ Name = "$Prefix-INFRA-MGMT"; Notes = 'VLAN 30 Infrastructure management' },
    @{ Name = "$Prefix-DMZ"; Notes = 'VLAN 40 DMZ' },
    @{ Name = "$Prefix-PRINT-IOT"; Notes = 'VLAN 60 Print and managed devices' },
    @{ Name = "$Prefix-MONITORING"; Notes = 'VLAN 70 Monitoring and security' },
    @{ Name = "$Prefix-OT"; Notes = 'VLAN 80 Plant OT' },
    @{ Name = "$Prefix-GUEST"; Notes = 'VLAN 90 Guest' },
    @{ Name = "$Prefix-NET-MGMT"; Notes = 'VLAN 99 Network management' }
)

foreach ($Switch in $Switches) {
    $Existing = Get-VMSwitch -Name $Switch.Name -ErrorAction SilentlyContinue

    if ($RemoveExisting -and $Existing) {
        if ($PSCmdlet.ShouldProcess($Switch.Name, 'Remove existing Hyper-V switch')) {
            Remove-VMSwitch -Name $Switch.Name -Force
        }
        $Existing = $null
    }

    if (-not $Existing) {
        if ($PSCmdlet.ShouldProcess($Switch.Name, "Create internal Hyper-V switch: $($Switch.Notes)")) {
            New-VMSwitch -Name $Switch.Name -SwitchType Internal -Notes $Switch.Notes | Out-Null
        }
    }
    else {
        Write-Verbose "Switch already exists: $($Switch.Name)"
    }
}

Write-Host 'Northstar isolated Hyper-V network switches are ready.'
Write-Host 'Connect OPNsense to the required interfaces and configure routing/firewall policy there.'
