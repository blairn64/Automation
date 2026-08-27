[CmdletBinding()]
param([string]$ComputerName = $env:COMPUTERNAME)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$members = if ($ComputerName -eq $env:COMPUTERNAME) {
    Get-LocalGroupMember -Group 'Administrators'
} else {
    Invoke-Command -ComputerName $ComputerName -ScriptBlock {
        Get-LocalGroupMember -Group 'Administrators'
    }
}

$members | Select-Object @{n='ComputerName';e={$ComputerName}},Name,ObjectClass,PrincipalSource | Format-Table -AutoSize
