[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string[]]$ServiceName = @('WinRM','Spooler','W32Time','BITS','EventLog')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script = {
    param($Names)
    Get-Service -Name $Names -ErrorAction SilentlyContinue |
        Select-Object @{n='ComputerName';e={$env:COMPUTERNAME}},Name,DisplayName,Status,StartType
}

$results = if ($ComputerName -eq $env:COMPUTERNAME) {
    & $script $ServiceName
} else {
    Invoke-Command -ComputerName $ComputerName -ScriptBlock $script -ArgumentList (,$ServiceName)
}

$results | Format-Table -AutoSize
