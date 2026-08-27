[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [int]$WarningDays = 30,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer -ErrorAction Stop
        $boot = $os.LastBootUpTime
        $uptime = (Get-Date) - $boot
        [pscustomobject]@{
            ComputerName = $computer
            LastBoot     = $boot
            UptimeDays   = [math]::Round($uptime.TotalDays, 1)
            UptimeHours  = [math]::Round($uptime.TotalHours, 1)
            Status       = if ($uptime.TotalDays -ge $WarningDays) { 'CHECK' } else { 'OK' }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            LastBoot     = $null
            UptimeDays   = $null
            UptimeHours  = $null
            Status       = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
