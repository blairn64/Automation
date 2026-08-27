[CmdletBinding()]
param(
    [string[]]$ComputerName = @('DC01','DC02','FS01','PRN01','APP01','SQL01'),
    [string[]]$DnsName = @('dc01.northstar.local','app01.northstar.local','sql01.northstar.local'),
    [int[]]$Ports = @(53,88,135,389,445,443),
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\evidence\health')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$results = New-Object System.Collections.Generic.List[object]

foreach ($computer in $ComputerName) {
    $reachable = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction SilentlyContinue
    $results.Add([pscustomobject]@{
        Timestamp = Get-Date
        Check = 'ICMP'
        Target = $computer
        Result = if ($reachable) { 'Healthy' } else { 'Failed' }
        Detail = if ($reachable) { 'Host responded' } else { 'No response' }
    })
}

foreach ($name in $DnsName) {
    try {
        $record = Resolve-DnsName -Name $name -ErrorAction Stop | Where-Object { $_.IPAddress } | Select-Object -First 1
        $results.Add([pscustomobject]@{ Timestamp=Get-Date; Check='DNS'; Target=$name; Result='Healthy'; Detail=$record.IPAddress })
    }
    catch {
        $results.Add([pscustomobject]@{ Timestamp=Get-Date; Check='DNS'; Target=$name; Result='Failed'; Detail=$_.Exception.Message })
    }
}

foreach ($computer in $ComputerName) {
    foreach ($port in $Ports) {
        try {
            $test = Test-NetConnection -ComputerName $computer -Port $port -WarningAction SilentlyContinue
            $results.Add([pscustomobject]@{
                Timestamp=Get-Date; Check='TCP'; Target="$computer`:$port"
                Result=if($test.TcpTestSucceeded){'Healthy'}else{'Failed'}
                Detail=if($test.TcpTestSucceeded){'Port reachable'}else{'Port unavailable'}
            })
        }
        catch {
            $results.Add([pscustomobject]@{ Timestamp=Get-Date; Check='TCP'; Target="$computer`:$port"; Result='Failed'; Detail=$_.Exception.Message })
        }
    }
}

New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null
$csv = Join-Path $OutputPath "northstar-health-$timestamp.csv"
$json = Join-Path $OutputPath "northstar-health-$timestamp.json"
$results | Export-Csv -NoTypeInformation -Path $csv
$results | ConvertTo-Json -Depth 4 | Set-Content -Path $json -Encoding UTF8

$results | Format-Table -AutoSize
Write-Host "Evidence written to $OutputPath"
