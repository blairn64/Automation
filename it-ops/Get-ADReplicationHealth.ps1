[CmdletBinding()]
param(
    [string[]]$ComputerName,
    [string]$OutputPath
)

Import-Module ActiveDirectory -ErrorAction Stop

if (-not $ComputerName) {
    $ComputerName = @((Get-ADDomainController -Filter *).HostName)
}

$results = foreach ($computer in $ComputerName) {
    try {
        $replication = Get-ADReplicationPartnerMetadata -Target $computer -ErrorAction Stop |
            Select-Object Partner, LastReplicationSuccess, LastReplicationResult, ConsecutiveReplicationFailures, IntersiteTransportType

        if (-not $replication) {
            [pscustomobject]@{
                ComputerName = $computer
                Partner = $null
                LastReplicationSuccess = $null
                LastReplicationResult = $null
                ConsecutiveReplicationFailures = $null
                IntersiteTransportType = $null
                Status = 'NO_PARTNERS_RETURNED'
            }
            continue
        }

        foreach ($row in $replication) {
            [pscustomobject]@{
                ComputerName = $computer
                Partner = $row.Partner
                LastReplicationSuccess = $row.LastReplicationSuccess
                LastReplicationResult = $row.LastReplicationResult
                ConsecutiveReplicationFailures = $row.ConsecutiveReplicationFailures
                IntersiteTransportType = $row.IntersiteTransportType
                Status = if ($row.LastReplicationResult -eq 0 -and $row.ConsecutiveReplicationFailures -eq 0) { 'OK' } else { 'CHECK' }
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            Partner = $null
            LastReplicationSuccess = $null
            LastReplicationResult = $null
            ConsecutiveReplicationFailures = $null
            IntersiteTransportType = $null
            Status = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Sort-Object Status, ComputerName | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
