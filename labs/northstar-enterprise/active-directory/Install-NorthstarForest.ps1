[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$DomainName = 'northstar.internal',
    [string]$NetBIOSName = 'NORTHSTAR',
    [securestring]$SafeModeAdministratorPassword
)

$ErrorActionPreference = 'Stop'

if (-not $SafeModeAdministratorPassword) {
    $SafeModeAdministratorPassword = Read-Host -Prompt 'Enter DSRM password for the synthetic Northstar forest' -AsSecureString
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Install AD DS forest $DomainName")) {
    Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
    Import-Module ADDSDeployment

    Install-ADDSForest `
        -DomainName $DomainName `
        -DomainNetbiosName $NetBIOSName `
        -InstallDNS `
        -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
        -Force
}
