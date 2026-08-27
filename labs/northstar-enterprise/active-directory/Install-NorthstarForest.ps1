[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$DomainName = 'northstar.internal',
    [string]$NetBIOSName = 'NORTHSTAR',
    [string]$DsrmPasswordFile = 'C:\NorthstarLab\secrets\dsrm-password.txt'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $DsrmPasswordFile)) {
    throw "DSRM password file not found: $DsrmPasswordFile. Create it locally; do not commit secrets."
}

if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME, "Install AD DS forest $DomainName")) {
    Install-WindowsFeature AD-Domain-Services, DNS -IncludeManagementTools
    Import-Module ADDSDeployment
    $securePassword = Get-Content $DsrmPasswordFile -Raw | ConvertTo-SecureString -AsPlainText -Force

    Install-ADDSForest `
        -DomainName $DomainName `
        -DomainNetbiosName $NetBIOSName `
        -InstallDNS `
        -SafeModeAdministratorPassword $securePassword `
        -Force
}
