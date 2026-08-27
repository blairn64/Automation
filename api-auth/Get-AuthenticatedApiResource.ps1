[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [uri]$Uri,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AccessToken,

    [ValidateRange(1,300)]
    [int]$TimeoutSec = 30,

    [ValidateRange(0,5)]
    [int]$MaxRetries = 2,

    [switch]$IncludeResponseMetadata
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Uri.Scheme -notin @('https','http')) {
    throw 'Only HTTP and HTTPS URIs are supported.'
}

$headers = @{ Authorization = "Bearer $AccessToken" }
$attempt = 0

while ($true) {
    try {
        $attempt++
        $response = Invoke-RestMethod -Uri $Uri -Headers $headers -Method Get -TimeoutSec $TimeoutSec
        if ($IncludeResponseMetadata) {
            return [pscustomobject]@{
                Uri          = $Uri.AbsoluteUri
                Attempt      = $attempt
                RetrievedUtc = (Get-Date).ToUniversalTime().ToString('o')
                Data         = $response
            }
        }
        return $response
    }
    catch {
        if ($attempt -gt $MaxRetries) {
            throw "API request failed after $attempt attempt(s): $($_.Exception.Message)"
        }
        Start-Sleep -Seconds ([math]::Min(2 * $attempt, 10))
    }
}
