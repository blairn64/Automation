[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$DomainName = 'northstar.internal',
    [Parameter(Mandatory)] [pscredential]$Credential,
    [string]$OUPath = 'OU=Workstations,OU=HQ,DC=northstar,DC=internal',
    [switch]$Restart
)

$ErrorActionPreference = 'Stop'

if ((Get-CimInstance Win32_ComputerSystem).PartOfDomain) {
    Write-Host 'Computer is already domain joined.'
    return
}

Add-Computer -DomainName $DomainName -Credential $Credential -OUPath $OUPath -ErrorAction Stop
Write-Host "Joined $env:COMPUTERNAME to $DomainName"

if ($Restart) { Restart-Computer -Force }
