[CmdletBinding()]
param(
    [ValidateRange(1,86400)]
    [int]$DurationSeconds = 300,
    [ValidateRange(1,3600)]
    [int]$IntervalSeconds = 10,
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\data\synthetic-events.jsonl')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

New-Item -ItemType Directory -Force -Path (Split-Path $OutputPath -Parent) | Out-Null
$departments = @('Finance','Engineering','Operations','HR','ServiceDesk')
$activities = @('Login','FileAccess','PrintJob','ApplicationRequest','TelemetryRead')
$start = Get-Date

while (((Get-Date) - $start).TotalSeconds -lt $DurationSeconds) {
    $event = [ordered]@{
        '@timestamp' = (Get-Date).ToUniversalTime().ToString('o')
        source = 'northstar-synthetic-workload'
        environment = 'northstar-lab'
        department = $departments | Get-Random
        activity = $activities | Get-Random
        host = $env:COMPUTERNAME
        correlation_id = [guid]::NewGuid().ToString()
        severity = 'information'
        message = 'Synthetic enterprise workload event'
    }

    ($event | ConvertTo-Json -Compress) | Add-Content -Path $OutputPath -Encoding UTF8
    Start-Sleep -Seconds $IntervalSeconds
}

Write-Host "Synthetic workload completed: $OutputPath"
