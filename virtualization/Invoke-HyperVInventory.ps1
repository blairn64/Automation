[CmdletBinding()]
param([string]$ComputerName=$env:COMPUTERNAME,[string]$OutputPath)

Import-Module Hyper-V -ErrorAction Stop
$vms = Get-VM -ComputerName $ComputerName | ForEach-Object {
    $memory = [math]::Round($_.MemoryAssigned / 1GB, 2)
    $checkpointCount = @(Get-VMSnapshot -VMName $_.Name -ComputerName $ComputerName -ErrorAction SilentlyContinue).Count
    [pscustomobject]@{
        VMName=$_.Name
        State=$_.State
        CPUCount=$_.ProcessorCount
        MemoryGB=$memory
        Checkpoints=$checkpointCount
        Uptime=$_.Uptime
    }
}
$vms | Sort-Object VMName | Format-Table -AutoSize
if ($OutputPath) { $vms | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
