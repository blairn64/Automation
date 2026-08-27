[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME)
)

foreach ($computer in $ComputerName) {
    try {
        $os = Get-CimInstance Win32_OperatingSystem -ComputerName $computer -ErrorAction Stop
        [pscustomobject]@{
            ComputerName = $computer
            LastBootTime = $os.LastBootUpTime
            UptimeDays = [math]::Round(((Get-Date) - $os.LastBootUpTime).TotalDays, 1)
            Platform = $os.Caption
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            LastBootTime = $null
            UptimeDays = $null
            Platform = "ERROR: $($_.Exception.Message)"
        }
    }
}
