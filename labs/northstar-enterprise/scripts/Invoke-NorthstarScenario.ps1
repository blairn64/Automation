[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('NS-INC-01','NS-INC-02','NS-INC-03','NS-INC-04','NS-INC-05')]
    [string]$Scenario,
    [ValidateSet('Inject','Validate','Recover')]
    [string]$Mode = 'Validate',
    [string]$EvidenceRoot = (Join-Path $PSScriptRoot '..\evidence')
)

$runId = '{0}-{1}' -f $Scenario,(Get-Date -Format 'yyyyMMdd-HHmmss')
$runPath = Join-Path $EvidenceRoot $runId
New-Item -ItemType Directory -Path $runPath -Force | Out-Null

$record = [ordered]@{
    RunId = $runId
    Scenario = $Scenario
    Mode = $Mode
    StartedUtc = (Get-Date).ToUniversalTime().ToString('o')
    Host = $env:COMPUTERNAME
}

$record | ConvertTo-Json | Set-Content (Join-Path $runPath 'run.json')

switch ($Scenario) {
    'NS-INC-01' {
        $record.Action = 'Validate telemetry pipeline: producer -> RabbitMQ -> consumer -> Elasticsearch'
        $record.Reversible = $true
    }
    'NS-INC-02' {
        $record.Action = 'Validate identity and DNS dependencies without modifying production credentials or directory data'
        $record.Reversible = $true
    }
    'NS-INC-03' {
        $record.Action = 'Validate print service and queue health'
        $record.Reversible = $true
    }
    'NS-INC-04' {
        $record.Action = 'Validate IIS/application availability and dependencies'
        $record.Reversible = $true
    }
    'NS-INC-05' {
        $record.Action = 'Validate capacity monitoring thresholds and recovery criteria'
        $record.Reversible = $true
    }
}

$record.CompletedUtc = (Get-Date).ToUniversalTime().ToString('o')
$record | ConvertTo-Json -Depth 4 | Set-Content (Join-Path $runPath 'result.json')
Write-Host "Scenario record written to $runPath"

# Fault injection is intentionally not hidden behind opaque commands.
# Implement scenario-specific reversible injectors in the scenario folders and review them before use.
