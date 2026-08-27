[CmdletBinding()]
param(
    [int]$Top = 10,
    [ValidateRange(1,100)]
    [int]$SampleCount = 1,
    [int]$DelaySeconds = 2,
    [string]$OutputPath
)

$first = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet64

if ($SampleCount -gt 1) {
    Start-Sleep -Seconds $DelaySeconds
}

$second = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet64
$cpuDelta = @{}
foreach ($p in $first) {
    $cpuDelta[$p.Id] = $p.CPU
}

$results = $second |
    ForEach-Object {
        $previous = $cpuDelta[$_.Id]
        $delta = if ($null -ne $previous -and $null -ne $_.CPU) { [math]::Round($_.CPU - $previous, 3) } else { 0 }
        [pscustomobject]@{
            ProcessName       = $_.ProcessName
            Id                = $_.Id
            CpuSecondsDelta   = $delta
            WorkingSetMB      = [math]::Round($_.WorkingSet64 / 1MB, 1)
        }
    } |
    Sort-Object CpuSecondsDelta -Descending |
    Select-Object -First $Top

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
