[CmdletBinding()]
param([string]$OutputPath)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module GroupPolicy

$allGpos = Get-GPO -All
$linkedNames = Get-GPInheritance -Target (Get-ADDomain).DistinguishedName |
    Select-Object -ExpandProperty GpoLinks |
    Select-Object -ExpandProperty DisplayName

$results = $allGpos |
    Where-Object { $_.DisplayName -notin $linkedNames } |
    Select-Object DisplayName,Id,GpoStatus,CreationTime,ModificationTime

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -NoTypeInformation -Path $OutputPath -Encoding utf8 }
