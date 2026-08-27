[CmdletBinding()]
param(
    [string]$SiteName,
    [switch]$IncludeBindings
)

Import-Module WebAdministration -ErrorAction Stop

$sites = if ($SiteName) {
    Get-Website -Name $SiteName -ErrorAction Stop
} else {
    Get-Website
}

$report = foreach ($site in $sites) {
    $appPools = Get-ChildItem "IIS:\Sites\$($site.Name)" -ErrorAction SilentlyContinue |
        Where-Object { $_.NodeType -eq 'application' } |
        Select-Object -ExpandProperty ApplicationPool -Unique

    [pscustomobject]@{
        SiteName      = $site.Name
        State         = $site.State
        PhysicalPath  = $site.PhysicalPath
        Bindings      = if ($IncludeBindings) { ($site.Bindings.Collection.bindingInformation -join '; ') } else { $null }
        ApplicationPool = ($appPools -join '; ')
    }
}

$report | Format-Table -AutoSize
