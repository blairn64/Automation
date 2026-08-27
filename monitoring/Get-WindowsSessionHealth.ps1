[CmdletBinding()]
param(
    [string]$ComputerName = 'localhost',
    [switch]$IncludeDisconnected
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-SessionHealth {
    param([string]$Computer)

    $raw = qwinsta /server:$Computer 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Unable to query sessions on $Computer."
    }

    $sessions = foreach ($line in $raw | Select-Object -Skip 1) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $clean = ($line -replace '^\s*>','') -replace '^\s+',''
        $parts = $clean -split '\s{2,}'
        if ($parts.Count -ge 4) {
            [pscustomobject]@{
                SessionName = $parts[0]
                UserName    = $parts[1]
                Id          = $parts[2]
                State       = $parts[3]
            }
        }
    }

    if (-not $IncludeDisconnected) {
        $sessions = $sessions | Where-Object State -ne 'Disc'
    }

    [pscustomobject]@{
        Computer = $Computer
        Checked  = Get-Date
        Sessions = @($sessions)
        Count    = @($sessions).Count
    }
}

$result = Get-SessionHealth -Computer $ComputerName
$result | ConvertTo-Json -Depth 5
