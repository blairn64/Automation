[CmdletBinding()]
param(
    [ValidateSet('Fixture','Graph')]
    [string]$Mode='Fixture',
    [string]$InputPath=(Join-Path $PSScriptRoot 'fixtures/incidents.json'),
    [string]$OutputPath
)

if ($Mode -eq 'Fixture') {
    $incidents = Get-Content -LiteralPath $InputPath -Raw | ConvertFrom-Json
}
else {
    Import-Module Microsoft.Graph.Security -ErrorAction Stop
    $incidents = Get-MgSecurityIncident -All | Select-Object Id,DisplayName,Severity,Status,CreatedDateTime,LastUpdateDateTime
}

$rows = $incidents | ForEach-Object {
    [pscustomobject]@{
        IncidentId=$_.Id
        Title=$_.DisplayName
        Severity=$_.Severity
        Status=$_.Status
        Created=$_.CreatedDateTime
        Updated=$_.LastUpdateDateTime
    }
}
$rows | Sort-Object Severity,Created | Format-Table -AutoSize
if ($OutputPath) { $rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
