[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$Name,
    [ValidateSet('A','AAAA','CNAME','MX','SRV','TXT')]
    [string]$Type = 'A',
    [string[]]$Server,
    [int]$Port = 443,
    [string]$OutputPath
)

$results = foreach ($target in $Name) {
    $lookup = $null
    $lookupError = $null

    try {
        $params = @{ Name = $target; Type = $Type; ErrorAction = 'Stop' }
        if ($Server) { $params.Server = $Server[0] }
        $lookup = @(Resolve-DnsName @params)
    }
    catch {
        $lookupError = $_.Exception.Message
    }

    $addresses = @($lookup | Where-Object IPAddress | Select-Object -ExpandProperty IPAddress)
    $reachable = $null
    if ($Type -in @('A','AAAA') -and [string]::IsNullOrEmpty($lookupError) -and $addresses.Count -gt 0) {
        $reachable = Test-NetConnection -ComputerName $target -Port $Port -InformationLevel Quiet -WarningAction SilentlyContinue
    }

    [pscustomobject]@{
        Name = $target
        Type = $Type
        DnsAnswers = $addresses -join ', '
        TcpPort = if ($Type -in @('A','AAAA')) { $Port } else { $null }
        TcpReachable = $reachable
        Status = if ($lookupError) { 'DNS_ERROR' } elseif ($Type -in @('A','AAAA') -and -not $reachable) { 'DNS_OK_NETWORK_FAIL' } else { 'OK' }
        Error = $lookupError
    }
}

$results | Format-Table -Wrap -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
