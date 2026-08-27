[CmdletBinding()]
param(
    [Parameter(Mandatory)] [uri]$Uri,
    [Parameter(Mandatory)] [string]$AccessToken,
    [int]$TimeoutSec = 30
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($AccessToken)) {
    throw 'Access token cannot be empty.'
}

$headers = @{ Authorization = "Bearer $AccessToken" }

try {
    Invoke-RestMethod -Uri $Uri -Headers $headers -Method Get -TimeoutSec $TimeoutSec
}
catch {
    throw "API request failed: $($_.Exception.Message)"
}
