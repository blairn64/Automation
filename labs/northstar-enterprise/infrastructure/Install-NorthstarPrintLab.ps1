[CmdletBinding()]
param(
    [string]$PrintServer = 'HQ-PRN01',
    [switch]$PlanOnly
)

$ErrorActionPreference = 'Stop'

$queues = @(
    [pscustomobject]@{ Name='HQ-FIN-01'; Location='HQ Finance'; Driver='Microsoft IPP Class Driver'; Port='IP_10.10.60.21' },
    [pscustomobject]@{ Name='HQ-OPS-01'; Location='HQ Operations'; Driver='Microsoft IPP Class Driver'; Port='IP_10.10.60.22' },
    [pscustomobject]@{ Name='PE-LABEL-01'; Location='Plant-East Labels'; Driver='Microsoft IPP Class Driver'; Port='IP_10.20.60.21' }
)

$queues | Format-Table -AutoSize

if ($PlanOnly) { return }

Install-WindowsFeature Print-Server -IncludeManagementTools | Out-Null

foreach ($queue in $queues) {
    if (-not (Get-PrinterPort -Name $queue.Port -ErrorAction SilentlyContinue)) {
        Add-PrinterPort -Name $queue.Port -PrinterHostAddress ($queue.Port -replace '^IP_','')
    }
    if (-not (Get-Printer -Name $queue.Name -ErrorAction SilentlyContinue)) {
        Add-Printer -Name $queue.Name -DriverName $queue.Driver -PortName $queue.Port -Shared -ShareName $queue.Name
    }
}

Write-Host "Northstar print lab configured on $PrintServer"
