[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$OutputPath
)

$items = Get-CimInstance Win32_ComputerSystem -ComputerName $ComputerName | ForEach-Object {
    [pscustomobject]@{
        ComputerName = $_.PSComputerName
        Manufacturer = $_.Manufacturer
        Model = $_.Model
        TotalMemoryGB = [math]::Round($_.TotalPhysicalMemory / 1GB, 2)
        HypervisorPresent = [bool]$_.HypervisorPresent
    }
}

if ($OutputPath) { $items | Export-Csv $OutputPath -NoTypeInformation }
$items | Format-Table -AutoSize
