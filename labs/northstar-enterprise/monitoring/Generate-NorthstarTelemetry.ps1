[CmdletBinding()]
param(
    [ValidateSet('Normal','Backlog','Outage')] [string] $Mode = 'Normal',
    [int] $Count = 25,
    [string] $OutputPath = "$PSScriptRoot/fixtures/telemetry.ndjson"
)

$directory = Split-Path $OutputPath -Parent
New-Item -ItemType Directory -Path $directory -Force | Out-Null

$events = for ($i=1; $i -le $Count; $i++) {
    $queueDepth = switch ($Mode) { 'Normal' { Get-Random -Minimum 0 -Maximum 20 } 'Backlog' { Get-Random -Minimum 250 -Maximum 900 } 'Outage' { 0 } }
    [ordered]@{
        '@timestamp' = (Get-Date).ToUniversalTime().ToString('o')
        environment = 'northstar-lab'
        site = if ($i % 2) {'Plant-East'} else {'Plant-West'}
        service = 'ot-telemetry'
        queue_depth = $queueDepth
        mode = $Mode
    } | ConvertTo-Json -Compress
}
$events | Set-Content -Path $OutputPath -Encoding utf8
Write-Host "Generated $Count synthetic telemetry events in $Mode mode"
