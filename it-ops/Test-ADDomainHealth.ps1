[CmdletBinding()]
param([string[]]$ComputerName)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

if (-not $ComputerName) {
    $ComputerName = (Get-ADDomainController -Filter *).HostName
}

foreach ($dc in $ComputerName) {
    $replication = Get-ADReplicationPartnerMetadata -Target $dc -ErrorAction SilentlyContinue
    [pscustomobject]@{
        DomainController = $dc
        Reachable        = Test-Connection -ComputerName $dc -Count 1 -Quiet
        ServiceState     = (Get-Service -ComputerName $dc -Name NTDS -ErrorAction SilentlyContinue).Status
        ReplicationPeers = @($replication).Count
        LastReplication  = ($replication | Sort-Object LastReplicationSuccess -Descending | Select-Object -First 1).LastReplicationSuccess
    }
}
