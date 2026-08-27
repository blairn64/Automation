[CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('^[a-zA-Z0-9._-]{1,20}$')]
    [string]$SamAccountName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$GivenName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Surname,

    [Parameter(Mandatory)]
    [ValidatePattern('^[^@\s]+@[^@\s]+\.[^@\s]+$')]
    [string]$UserPrincipalName,

    [ValidateNotNullOrEmpty()]
    [string]$Path = 'OU=LabUsers,DC=example,DC=invalid',

    [string[]]$Groups = @(),

    [switch]$PassThru
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command New-ADUser -ErrorAction SilentlyContinue)) {
    throw 'ActiveDirectory PowerShell module is not available.'
}

$displayName = "$GivenName $Surname"

if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
    throw "A user with SamAccountName '$SamAccountName' already exists."
}

$userParameters = @{
    SamAccountName    = $SamAccountName
    UserPrincipalName = $UserPrincipalName
    GivenName         = $GivenName
    Surname           = $Surname
    Name              = $displayName
    DisplayName       = $displayName
    Path              = $Path
    Enabled           = $false
}

$created = $false
if ($PSCmdlet.ShouldProcess($displayName, 'Create disabled lab Active Directory user')) {
    New-ADUser @userParameters
    $created = $true

    foreach ($group in $Groups) {
        if (-not (Get-ADGroup -Identity $group -ErrorAction SilentlyContinue)) {
            throw "Requested group '$group' does not exist. User was created disabled; review group membership manually."
        }
        if ($PSCmdlet.ShouldProcess($group, "Add $displayName to group")) {
            Add-ADGroupMember -Identity $group -Members $SamAccountName
        }
    }
}

$result = [pscustomobject]@{
    SamAccountName    = $SamAccountName
    DisplayName       = $displayName
    UserPrincipalName = $UserPrincipalName
    Path              = $Path
    Created           = $created
    Enabled           = $false
    GroupsRequested   = $Groups
    TimestampUtc      = (Get-Date).ToUniversalTime().ToString('o')
}

if ($PassThru) { $result } else { $result | Format-List }
