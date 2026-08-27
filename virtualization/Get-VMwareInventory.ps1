[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$Server,
    [string]$OutputPath
)

if (-not (Get-Module -ListAvailable -Name VMware.PowerCLI)) {
    throw 'Install VMware.PowerCLI in an authorised environment before using live mode.'
}

Import-Module VMware.PowerCLI -ErrorAction Stop
$connection = Connect-VIServer -Server $Server -ErrorAction Stop
try {
    $rows = Get-VM | ForEach-Object {
        [pscustomobject]@{
            VMName=$_.Name
            PowerState=$_.PowerState
            CPUCount=$_.NumCpu
            MemoryGB=$_.MemoryGB
            HostName=$_.VMHost.Name
            Datastore=($_ | Get-Datastore | Select-Object -ExpandProperty Name -First 1)
        }
    }
    $rows | Sort-Object VMName | Format-Table -AutoSize
    if ($OutputPath) { $rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
}
finally {
    Disconnect-VIServer -Server $connection -Confirm:$false | Out-Null
}
