[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$ComputerName,
    [int]$Port = 443,
    [int]$TimeoutMilliseconds = 1500,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    $ping = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction SilentlyContinue
    $tcp = Test-NetConnection -ComputerName $computer -Port $Port -InformationLevel Quiet -WarningAction SilentlyContinue

    [pscustomobject]@{
        ComputerName = $computer
        Ping          = $ping
        TcpPort      = $Port
        TcpReachable = $tcp
        Status        = if ($ping -or $tcp) { 'Reachable' } else { 'Unreachable' }
        CheckedAt     = Get-Date
    }
}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
