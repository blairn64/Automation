[CmdletBinding()]
param(
    [string[]]$ComputerName = @('DC01','DC02','FS01','PRN01','APP01','SQL01','MQ01','MON01'),
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\evidence\recovery-validation.json')
)

$results = foreach ($computer in $ComputerName) {
    $ping = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction SilentlyContinue
    [pscustomobject]@{
        ComputerName = $computer
        Reachable = [bool]$ping
        CheckedUtc = (Get-Date).ToUniversalTime().ToString('o')
    }
}

$failed = @($results | Where-Object { -not $_.Reachable })
$summary = [ordered]@{
    CheckedUtc = (Get-Date).ToUniversalTime().ToString('o')
    Total = @($results).Count
    Reachable = @($results | Where-Object Reachable).Count
    Unreachable = $failed.Count
    Passed = ($failed.Count -eq 0)
    Results = $results
}

$directory = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Path $directory -Force | Out-Null
$summary | ConvertTo-Json -Depth 5 | Set-Content $OutputPath

$summary | Format-Table -AutoSize
if (-not $summary.Passed) {
    Write-Warning 'Recovery validation found unreachable dependencies. Review evidence before declaring the incident closed.'
}
