[CmdletBinding()]
param(
    [int]$InactiveDays = 90,
    [string]$SearchBase,
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Import-Module ActiveDirectory

$cutoff = (Get-Date).AddDays(-$InactiveDays)
$params = @{ Filter = '*' }
if ($SearchBase) { $params.SearchBase = $SearchBase }

Get-ADUser @params -Properties Enabled,LastLogonDate,PasswordLastSet,DistinguishedName |
    Where-Object { $_.Enabled -and ($null -eq $_.LastLogonDate -or $_.LastLogonDate -lt $cutoff) } |
    Select-Object SamAccountName,Name,LastLogonDate,PasswordLastSet,DistinguishedName |
    Sort-Object LastLogonDate |
    Tee-Object -Variable results |
    Format-Table -AutoSize

if ($OutputPath) {
    $results | Export-Csv -NoTypeInformation -Path $OutputPath -Encoding utf8
}
