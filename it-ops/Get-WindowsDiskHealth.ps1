[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [ValidateRange(1,99)]
    [int]$MinimumFreePercent = 15,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $disks = Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $computer -Filter "DriveType=3" -ErrorAction Stop
        foreach ($disk in $disks) {
            $freePercent = if ($disk.Size) { [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2) } else { 0 }
            [pscustomobject]@{
                ComputerName    = $computer
                Drive           = $disk.DeviceID
                SizeGB          = [math]::Round($disk.Size / 1GB, 2)
                FreeGB          = [math]::Round($disk.FreeSpace / 1GB, 2)
                FreePercent     = $freePercent
                Status          = if ($freePercent -lt $MinimumFreePercent) { 'CHECK' } else { 'OK' }
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName    = $computer
            Drive           = $null
            SizeGB          = $null
            FreeGB          = $null
            FreePercent     = $null
            Status          = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
