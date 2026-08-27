<#
.SYNOPSIS
Creates synthetic Northstar DHCP scopes.
.DESCRIPTION
Run on the authorised DHCP server after DHCP role installation and AD authorisation.
Scope options point clients at the Northstar DNS pair and OPNsense gateways.
#>
[CmdletBinding(SupportsShouldProcess)]
param()

Import-Module DhcpServer -ErrorAction Stop

$scopes = @(
    @{Name='HQ-CORP-USERS';Network='10.10.10.0';Start='10.10.10.100';End='10.10.10.220';Mask='255.255.255.0';Gateway='10.10.10.1'},
    @{Name='HQ-PRINT-IOT';Network='10.10.60.0';Start='10.10.60.100';End='10.10.60.180';Mask='255.255.255.0';Gateway='10.10.60.1'},
    @{Name='PLANT-EAST-USERS';Network='10.20.10.0';Start='10.20.10.100';End='10.20.10.220';Mask='255.255.255.0';Gateway='10.20.10.1'},
    @{Name='PLANT-WEST-USERS';Network='10.30.10.0';Start='10.30.10.100';End='10.30.10.220';Mask='255.255.255.0';Gateway='10.30.10.1'}
)

foreach ($scope in $scopes) {
    if (-not (Get-DhcpServerv4Scope -ScopeId $scope.Network -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($scope.Name, 'Create DHCP scope')) {
            Add-DhcpServerv4Scope -Name $scope.Name -StartRange $scope.Start -EndRange $scope.End -SubnetMask $scope.Mask -State Active
            Set-DhcpServerv4OptionValue -ScopeId $scope.Network -Router $scope.Gateway -DnsServer '10.10.20.10','10.10.20.11' -DnsDomain 'northstar.internal'
        }
    }
}

Write-Host 'Northstar DHCP scopes configured.' -ForegroundColor Green
