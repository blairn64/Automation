[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Name,
    [string]$Server,
    [ValidateSet('A','AAAA','CNAME','MX','NS','TXT')]
    [string]$Type = 'A'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$resolveParams = @{ Name = $Name; Type = $Type }
if ($Server) { $resolveParams.Server = $Server }

try {
    $records = Resolve-DnsName @resolveParams -ErrorAction Stop
    $sw.Stop()
    $records |
        Select-Object Name,Type,IPAddress,NameHost,Preference,Strings,
            @{n='ResponseTimeMs';e={$sw.ElapsedMilliseconds}}
}
catch {
    $sw.Stop()
    [pscustomobject]@{
        Name = $Name
        Type = $Type
        Success = $false
        ResponseTimeMs = $sw.ElapsedMilliseconds
        Error = $_.Exception.Message
    }
}
