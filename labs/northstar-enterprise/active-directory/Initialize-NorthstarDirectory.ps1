<#
.SYNOPSIS
Initialises the Northstar Manufacturing Group synthetic Active Directory structure.
.DESCRIPTION
Creates OUs, role-based groups and synthetic user/service accounts. Run after a domain
controller for northstar.internal is available. No real people, employers or production
identities are represented.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$DomainDN = 'DC=northstar,DC=internal',
    [switch]$CreateDemoUsers
)

Import-Module ActiveDirectory -ErrorAction Stop

$ous = @(
    'HQ','Plant-East','Plant-West','Infrastructure','Privileged','Service Accounts',
    'Users','Workstations','Servers','OT','Groups'
)

$paths = @(
    @{Name='HQ';Path=$DomainDN},
    @{Name='Plant-East';Path=$DomainDN},
    @{Name='Plant-West';Path=$DomainDN},
    @{Name='Infrastructure';Path=$DomainDN},
    @{Name='Privileged';Path=$DomainDN},
    @{Name='Service Accounts';Path=$DomainDN},
    @{Name='Groups';Path=$DomainDN}
)

foreach ($item in $paths) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$($item.Name))" -SearchBase $item.Path -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess("OU=$($item.Name),$($item.Path)", 'Create organizational unit')) {
            New-ADOrganizationalUnit -Name $item.Name -Path $item.Path -ProtectedFromAccidentalDeletion $true
        }
    }
}

$childOUs = @(
    @{Name='Users';Path="OU=HQ,$DomainDN"}, @{Name='Workstations';Path="OU=HQ,$DomainDN"}, @{Name='Servers';Path="OU=HQ,$DomainDN"},
    @{Name='Users';Path="OU=Plant-East,$DomainDN"}, @{Name='Workstations';Path="OU=Plant-East,$DomainDN"}, @{Name='OT';Path="OU=Plant-East,$DomainDN"},
    @{Name='Users';Path="OU=Plant-West,$DomainDN"}, @{Name='Workstations';Path="OU=Plant-West,$DomainDN"}, @{Name='OT';Path="OU=Plant-West,$DomainDN"}
)
foreach ($item in $childOUs) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(ou=$($item.Name))" -SearchBase $item.Path -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $item.Name -Path $item.Path -ProtectedFromAccidentalDeletion $true
    }
}

$groups = @('GG-HQ-IT-Admins','GG-HQ-Server-Admins','GG-Plant-East-Operators','GG-Plant-West-Operators','GG-Finance-Modify','GG-Engineering-Modify','GG-Operations-Modify','GG-Monitoring-Operators')
foreach ($group in $groups) {
    if (-not (Get-ADGroup -Filter "SamAccountName -eq '$group'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $group -SamAccountName $group -GroupScope Global -GroupCategory Security -Path "OU=Groups,$DomainDN"
    }
}

if ($CreateDemoUsers) {
    $password = ConvertTo-SecureString 'ChangeMeInYourLab!123' -AsPlainText -Force
    $users = @(
        @{Given='Jamie';Surname='Taylor';Sam='jamie.taylor';OU="OU=Users,OU=HQ,$DomainDN";Dept='IT'},
        @{Given='Morgan';Surname='Reed';Sam='morgan.reed';OU="OU=Users,OU=HQ,$DomainDN";Dept='Engineering'},
        @{Given='Casey';Surname='Patel';Sam='casey.patel';OU="OU=Users,OU=Plant-East,$DomainDN";Dept='Operations'}
    )
    foreach ($user in $users) {
        if (-not (Get-ADUser -Filter "SamAccountName -eq '$($user.Sam)'" -ErrorAction SilentlyContinue)) {
            New-ADUser -Name "$($user.Given) $($user.Surname)" -GivenName $user.Given -Surname $user.Surname -SamAccountName $user.Sam -UserPrincipalName "$($user.Sam)@northstar.internal" -Department $user.Dept -Path $user.OU -AccountPassword $password -Enabled $true -ChangePasswordAtLogon $true
        }
    }
}

Write-Host 'Northstar directory baseline complete.' -ForegroundColor Green
