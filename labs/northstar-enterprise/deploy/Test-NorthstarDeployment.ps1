[CmdletBinding()]
param(
    [string[]]$ComputerName = @('DC01','DC02','FS01','PRN01','APP01','SQL01','MQ01','MON01'),
    [hashtable]$Ports = @{ DC01=53; DC02=53; FS01=445; PRN01=445; APP01=443; SQL01=1433; MQ01=5672; MON01=9200 },
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\evidence\deployment-validation.json')
)

$results = foreach ($name in $ComputerName) {
    $reachable = Test-Connection -ComputerName $name -Count 1 -Quiet -ErrorAction SilentlyContinue
    $port = $Ports[$name]
    $portOpen = $false
    if ($reachable -and $port) {
        $portOpen = Test-NetConnection -ComputerName $name -Port $port -InformationLevel Quiet -WarningAction SilentlyContinue
    }
    [pscustomobject]@{
        ComputerName = $name
        Reachable = [bool]$reachable
        Port = $port
        PortOpen = [bool]$portOpen
        CheckedUtc = (Get-Date).ToUniversalTime().ToString('o')
    }
}

$summary = [ordered]@{
    CheckedUtc = (Get-Date).ToUniversalTime().ToString('o')
    Passed = -not ($results | Where-Object { -not $_.Reachable -or -not $_.PortOpen })
    Results = $results
}
New-Item -ItemType Directory -Path (Split-Path $OutputPath -Parent) -Force | Out-Null
$summary | ConvertTo-Json -Depth 5 | Set-Content $OutputPath
$results | Format-Table -AutoSize
if (-not $summary.Passed) { Write-Warning 'One or more deployment checks failed. Review the evidence output.' }
