[CmdletBinding()]
param(
    [string[]]$ExcludeName = @('Domain Users','Domain Computers','Domain Admins','Enterprise Admins','Administrators'),
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$results = Get-ADGroup -Filter * -Properties Members |
    Where-Object { $_.Name -notin $ExcludeName -and $_.Members.Count -eq 0 } |
    Select-Object Name,GroupScope,GroupCategory,DistinguishedName

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -NoTypeInformation -Path $OutputPath -Encoding utf8 }
