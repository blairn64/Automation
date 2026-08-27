[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Scenario,
    [string]$OutputRoot = (Join-Path $PSScriptRoot '..\evidence')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$root = Join-Path $OutputRoot "$Scenario-$stamp"
$folders = 'baseline','detection','investigation','recovery','validation'
foreach ($folder in $folders) { New-Item -ItemType Directory -Path (Join-Path $root $folder) -Force | Out-Null }

Get-Date | Out-File (Join-Path $root 'baseline\timestamp.txt')
Get-CimInstance Win32_OperatingSystem | Select-Object CSName,Caption,Version,LastBootUpTime |
    ConvertTo-Json | Set-Content (Join-Path $root 'baseline\system.json')
Get-Service | Sort-Object Status,Name | Select-Object Name,Status,StartType |
    Export-Csv (Join-Path $root 'baseline\services.csv') -NoTypeInformation
Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select-Object DeviceID,Size,FreeSpace |
    Export-Csv (Join-Path $root 'baseline\storage.csv') -NoTypeInformation

@"
# $Scenario RCA

## Summary

## Impact

## Detection

## Root cause

## Recovery

## Validation

## Preventative actions
"@ | Set-Content (Join-Path $root 'RCA.md')

Write-Output ([pscustomobject]@{Scenario=$Scenario;EvidencePath=$root;CreatedUtc=(Get-Date).ToUniversalTime().ToString('o')})
