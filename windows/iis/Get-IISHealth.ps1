[CmdletBinding()]
param(
    [string]$ComputerName = 'localhost',
    [string]$Url = 'http://localhost/'
)

$ErrorActionPreference = 'Stop'

$result = [ordered]@{
    ComputerName = $ComputerName
    TimestampUtc = [DateTime]::UtcNow.ToString('o')
    Url = $Url
    WebRequestStatus = 'NotTested'
    HttpStatus = $null
    AppPoolCount = $null
    SiteCount = $null
}

try {
    $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 10
    $result.WebRequestStatus = 'OK'
    $result.HttpStatus = [int]$response.StatusCode
}
catch {
    $result.WebRequestStatus = $_.Exception.Message
}

if ($ComputerName -in @('localhost', $env:COMPUTERNAME)) {
    try {
        Import-Module WebAdministration -ErrorAction Stop
        $result.AppPoolCount = @(Get-ChildItem IIS:\AppPools).Count
        $result.SiteCount = @(Get-ChildItem IIS:\Sites).Count
    }
    catch {
        $result.AppPoolCount = 'Unavailable'
        $result.SiteCount = 'Unavailable'
    }
}

[pscustomobject]$result
