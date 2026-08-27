[CmdletBinding()]
param(
    [ValidateSet('Fixture','Graph')]
    [string]$Mode='Fixture',
    [string]$InputPath=(Join-Path $PSScriptRoot 'fixtures/sites.json'),
    [string]$OutputPath
)

if ($Mode -eq 'Fixture') {
    $sites = Get-Content -LiteralPath $InputPath -Raw | ConvertFrom-Json
}
else {
    Import-Module Microsoft.Graph.Sites -ErrorAction Stop
    $sites = Get-MgSite -All | Select-Object Id,DisplayName,WebUrl,SiteCollection
}

$rows = $sites | ForEach-Object {
    [pscustomobject]@{
        DisplayName=$_.DisplayName
        WebUrl=$_.WebUrl
        SiteId=$_.Id
        Template=if ($_.SiteCollection) { $_.SiteCollection.Hostname } else { 'n/a' }
    }
}
$rows | Sort-Object DisplayName | Format-Table -AutoSize
if ($OutputPath) { $rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
