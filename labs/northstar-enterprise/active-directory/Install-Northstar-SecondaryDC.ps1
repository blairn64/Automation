#Requires -RunAsAdministrator
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $DomainName,
    [Parameter(Mandatory)] [pscredential] $DomainAdminCredential,
    [string] $SiteName = 'HQ'
)

$ErrorActionPreference = 'Stop'
Install-WindowsFeature AD-Domain-Services,DNS -IncludeManagementTools
Import-Module ADDSDeployment
Install-ADDSDomainController -DomainName $DomainName -Credential $DomainAdminCredential -InstallDns -SiteName $SiteName -Force
