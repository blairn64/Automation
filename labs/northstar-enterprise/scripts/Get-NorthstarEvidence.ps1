[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Telemetry','IdentityDNS','Print','Application','Capacity')]
    [string]$Scenario,
    [string]$EvidenceRoot = (Join-Path $PSScriptRoot '..\evidence')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$path = Join-Path $EvidenceRoot "$Scenario\$stamp"
New-Item -ItemType Directory -Force -Path $path | Out-Null

$summary = [ordered]@{
    Scenario = $Scenario
    CapturedAt = (Get-Date).ToString('o')
    Host = $env:COMPUTERNAME
    User = $env:USERNAME
}
$summary | ConvertTo-Json | Set-Content (Join-Path $path 'summary.json') -Encoding UTF8

Get-Date | Set-Content (Join-Path $path 'timestamp.txt')
Get-Service | Sort-Object Status,DisplayName | Out-File (Join-Path $path 'services.txt')
Get-Process | Sort-Object CPU -Descending | Select-Object -First 50 | Format-Table -AutoSize | Out-String | Set-Content (Join-Path $path 'top-processes.txt')
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID,Size,FreeSpace | ConvertTo-Json | Set-Content (Join-Path $path 'disk.json')
Get-NetIPConfiguration | Out-File (Join-Path $path 'network.txt')

if (Get-Command Get-WinEvent -ErrorAction SilentlyContinue) {
    Get-WinEvent -LogName System -MaxEvents 200 -ErrorAction SilentlyContinue |
        Select-Object TimeCreated,Id,LevelDisplayName,ProviderName,Message |
        Export-Csv -NoTypeInformation -Path (Join-Path $path 'system-events.csv')
}

Write-Host "Evidence captured: $path"
