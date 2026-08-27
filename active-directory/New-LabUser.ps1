[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$SamAccountName,
    [Parameter(Mandatory)] [string]$GivenName,
    [Parameter(Mandatory)] [string]$Surname,
    [Parameter(Mandatory)] [string]$UserPrincipalName,
    [string]$Path = 'OU=LabUsers,DC=example,DC=invalid',
    [string[]]$Groups = @()
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command New-ADUser -ErrorAction SilentlyContinue)) {
    throw 'ActiveDirectory PowerShell module is not available.'
}

$displayName = "$GivenName $Surname"
$userParams = @{
    SamAccountName    = $SamAccountName
    UserPrincipalName = $UserPrincipalName
    GivenName         = $GivenName
    Surname           = $Surname
    Name              = $displayName
    DisplayName       = $displayName
    Path              = $Path
    Enabled           = $false
}

if ($PSCmdlet.ShouldProcess($displayName, 'Create lab Active Directory user')) {
    New-ADUser @userParams

    foreach ($group in $Groups) {
        if ($PSCmdlet.ShouldProcess($group, "Add $displayName to group")) {
            Add-ADGroupMember -Identity $group -Members $SamAccountName
        }
    }
}

Write-Output "Prepared lab user $displayName ($SamAccountName)"
