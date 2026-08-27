[CmdletBinding()]
param(
    [int]$Events = 250,
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\data\synthetic-workload.jsonl')
)

$departments = 'Finance','Engineering','Operations','HR','ServiceDesk'
$activities = 'SignIn','FileAccess','PrintJob','ApplicationRequest','TelemetryRead','PasswordFailure'

$directory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Path $directory -Force | Out-Null

1..$Events | ForEach-Object {
    $department = Get-Random $departments
    $activity = Get-Random $activities
    $event = [ordered]@{
        '@timestamp' = (Get-Date).ToUniversalTime().ToString('o')
        correlation_id = [guid]::NewGuid().ToString()
        environment = 'northstar-lab'
        site = Get-Random @('HQ','Plant-01','Plant-02')
        department = $department
        activity = $activity
        severity = if ($activity -eq 'PasswordFailure') { 'warning' } else { 'info' }
        synthetic = $true
    }
    $event | ConvertTo-Json -Compress | Add-Content $OutputPath
}

Write-Host "Generated $Events synthetic events at $OutputPath"
