[CmdletBinding()]
param(
    [ValidateSet('Fixture','Graph')]
    [string]$Mode='Fixture',
    [string]$InputPath=(Join-Path $PSScriptRoot 'fixtures/teams.json'),
    [string]$OutputPath
)

if ($Mode -eq 'Fixture') {
    $teams = Get-Content -LiteralPath $InputPath -Raw | ConvertFrom-Json
}
else {
    Import-Module Microsoft.Graph.Teams -ErrorAction Stop
    $teams = Get-MgTeam -All | Select-Object Id,DisplayName,Description,Visibility
}

$rows = $teams | ForEach-Object {
    [pscustomobject]@{
        TeamId=$_.Id
        DisplayName=$_.DisplayName
        Visibility=$_.Visibility
        Description=$_.Description
    }
}
$rows | Sort-Object DisplayName | Format-Table -AutoSize
if ($OutputPath) { $rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
