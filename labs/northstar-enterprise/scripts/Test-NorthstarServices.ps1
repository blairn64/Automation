[CmdletBinding()]
param(
    [hashtable]$ServiceMap = @{
        'DC01' = @('NTDS','DNS')
        'DC02' = @('NTDS','DNS')
        'PRN01' = @('Spooler')
        'APP01' = @('W3SVC')
        'SQL01' = @('MSSQLSERVER')
    },
    [string]$OutputPath = (Join-Path $PSScriptRoot '..\evidence\services')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'
$results = foreach ($hostName in $ServiceMap.Keys) {
    foreach ($serviceName in $ServiceMap[$hostName]) {
        try {
            $service = Get-Service -ComputerName $hostName -Name $serviceName -ErrorAction Stop
            [pscustomobject]@{
                Timestamp = Get-Date
                Host = $hostName
                Service = $serviceName
                Status = $service.Status
                Healthy = $service.Status -eq 'Running'
            }
        }
        catch {
            [pscustomobject]@{
                Timestamp = Get-Date
                Host = $hostName
                Service = $serviceName
                Status = 'Unavailable'
                Healthy = $false
            }
        }
    }
}

New-Item -ItemType Directory -Force -Path $OutputPath | Out-Null
$file = Join-Path $OutputPath "service-health-$(Get-Date -Format yyyyMMdd-HHmmss).csv"
$results | Export-Csv -NoTypeInformation -Path $file
$results | Format-Table -AutoSize
Write-Host "Service health evidence: $file"
