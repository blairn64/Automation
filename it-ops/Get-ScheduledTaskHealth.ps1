[CmdletBinding()]
param(
    [string[]]$ComputerName = @($env:COMPUTERNAME),
    [switch]$IncludeDisabled,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $tasks = Invoke-Command -ComputerName $computer -ScriptBlock {
            Get-ScheduledTask -ErrorAction Stop | ForEach-Object {
                if ($using:IncludeDisabled -or $_.State -ne 'Disabled') {
                    $info = $_ | Get-ScheduledTaskInfo -ErrorAction SilentlyContinue
                    [pscustomobject]@{
                        TaskName       = $_.TaskName
                        TaskPath       = $_.TaskPath
                        State          = $_.State
                        LastRunTime    = $info.LastRunTime
                        NextRunTime    = $info.NextRunTime
                        LastTaskResult = $info.LastTaskResult
                    }
                }
            }
        }

        foreach ($task in $tasks) {
            [pscustomobject]@{
                ComputerName   = $computer
                TaskName       = $task.TaskName
                TaskPath       = $task.TaskPath
                State          = $task.State
                LastRunTime    = $task.LastRunTime
                NextRunTime    = $task.NextRunTime
                LastTaskResult = $task.LastTaskResult
                Status         = if ($task.LastTaskResult -eq 0) { 'OK' } else { 'CHECK' }
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName   = $computer
            TaskName       = $null
            TaskPath       = $null
            State          = $null
            LastRunTime    = $null
            NextRunTime    = $null
            LastTaskResult = $null
            Status         = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
