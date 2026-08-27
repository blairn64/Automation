[CmdletBinding()]
param(
    [ValidateRange(1,168)]
    [int]$Hours = 24,
    [int]$MaxEvents = 200,
    [ValidateSet('System','Application','Security')]
    [string]$LogName = 'System',
    [string]$OutputPath
)

$start = (Get-Date).AddHours(-$Hours)

$filter = @{
    LogName   = $LogName
    StartTime = $start
}

$events = Get-WinEvent -FilterHashtable $filter -MaxEvents $MaxEvents -ErrorAction Stop |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, MachineName, Message

$events | Format-Table TimeCreated, Id, LevelDisplayName, ProviderName -AutoSize
if ($OutputPath) { $events | Export-Csv -Path $OutputPath -NoTypeInformation }
