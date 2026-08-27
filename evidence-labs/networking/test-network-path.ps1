[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$ComputerName,
    [Parameter(Mandatory)] [int[]]$Port
)

foreach ($p in $Port) {
    $result = Test-NetConnection -ComputerName $ComputerName -Port $p -WarningAction SilentlyContinue
    [pscustomobject]@{
        Target = $ComputerName
        Port = $p
        TcpTestSucceeded = $result.TcpTestSucceeded
        RemoteAddress = $result.RemoteAddress
    }
}
