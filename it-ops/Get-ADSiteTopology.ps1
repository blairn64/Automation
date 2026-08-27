[CmdletBinding()]
param(
    [string]$OutputPath
)

Import-Module ActiveDirectory -ErrorAction Stop

$sites = Get-ADReplicationSite -Filter * | Select-Object Name, DistinguishedName
$links = Get-ADReplicationSiteLink -Filter * | Select-Object Name, Cost, ReplicationFrequencyInMinutes, SitesIncluded
$subnets = Get-ADReplicationSubnet -Filter * | Select-Object Name, Site

$report = foreach ($site in $sites) {
    $linkedSubnets = @($subnets | Where-Object { $_.Site -like "*$($site.Name)*" } | Select-Object -ExpandProperty Name)
    $siteLinks = @($links | Where-Object { $_.SitesIncluded -contains $site.Name } | Select-Object -ExpandProperty Name)

    [pscustomobject]@{
        Site = $site.Name
        Subnets = ($linkedSubnets -join ', ')
        SiteLinks = ($siteLinks -join ', ')
        SubnetCount = $linkedSubnets.Count
        SiteLinkCount = $siteLinks.Count
    }
}

$report | Format-Table -AutoSize
if ($OutputPath) { $report | Export-Csv -Path $OutputPath -NoTypeInformation }

Write-Verbose ("Discovered {0} sites, {1} site links and {2} subnets." -f $sites.Count, $links.Count, $subnets.Count)
