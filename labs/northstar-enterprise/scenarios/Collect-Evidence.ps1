[CmdletBinding()]
param(
    [Parameter(Mandatory)] [ValidateSet('TelemetryBacklog','IdentityDns','PrintSpooler')] [string]$Scenario,
    [string]$OutputRoot = (Join-Path $PSScriptRoot '..\evidence'),
    [switch]$IncludeDockerLogs
)

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$out = Join-Path $OutputRoot "$Scenario-$timestamp"
New-Item -ItemType Directory -Path $out -Force | Out-Null

Get-Date | Set-Content (Join-Path $out 'collected-at.txt')
Get-ComputerInfo | Out-File (Join-Path $out 'computer-info.txt')
Get-Service | Sort-Object Status,Name | Format-Table -AutoSize | Out-File (Join-Path $out 'services.txt')
Get-Process | Sort-Object CPU -Descending | Select-Object -First 50 | Format-Table -AutoSize | Out-File (Join-Path $out 'top-processes.txt')
Get-WinEvent -LogName System -MaxEvents 100 -ErrorAction SilentlyContinue |
    Select-Object TimeCreated,Id,LevelDisplayName,ProviderName,Message |
    Export-Csv (Join-Path $out 'system-events.csv') -NoTypeInformation

if ($IncludeDockerLogs -and (Get-Command docker -ErrorAction SilentlyContinue)) {
    docker compose ps | Out-File (Join-Path $out 'docker-ps.txt')
    docker compose logs --tail 200 | Out-File (Join-Path $out 'docker-logs.txt')
}

@{
    scenario = $Scenario
    collected_at = (Get-Date).ToUniversalTime().ToString('o')
    host = $env:COMPUTERNAME
    evidence_path = $out
} | ConvertTo-Json | Set-Content (Join-Path $out 'manifest.json')

Write-Host "Evidence collected: $out" -ForegroundColor Green
