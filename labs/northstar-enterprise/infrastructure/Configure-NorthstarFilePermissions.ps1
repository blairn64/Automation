#Requires -RunAsAdministrator
[CmdletBinding()]
param(
    [string] $Root = 'D:\NorthstarShares',
    [string] $DomainNetbios = 'NORTHSTAR'
)

$ErrorActionPreference = 'Stop'
$departments = 'Finance','Engineering','Operations','HR','IT','Plant-East','Plant-West'
New-Item -ItemType Directory -Path $Root -Force | Out-Null

foreach ($department in $departments) {
    $path = Join-Path $Root $department
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    $acl = Get-Acl $path
    $acl.SetAccessRuleProtection($true,$false)
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$DomainNetbios\SG-$department-RW",'Modify','ContainerInherit,ObjectInherit','None','Allow')
    $acl.AddAccessRule($rule)
    Set-Acl -Path $path -AclObject $acl
    Write-Host "Configured $department share permissions"
}
