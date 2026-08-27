[CmdletBinding()]
param(
    [ValidateSet('Fixture','Graph')]
    [string]$Mode = 'Fixture',
    [string]$InputPath = (Join-Path $PSScriptRoot 'fixtures/devices.json'),
    [string]$OutputPath
)

function Get-DeviceData {
    param([string]$ModeValue, [string]$Path)

    if ($ModeValue -eq 'Fixture') {
        if (-not (Test-Path -LiteralPath $Path)) { throw "Fixture not found: $Path" }
        return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    }

    if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.DeviceManagement)) {
        throw 'Install Microsoft.Graph.DeviceManagement or use -Mode Fixture.'
    }

    Import-Module Microsoft.Graph.DeviceManagement -ErrorAction Stop
    Get-MgDeviceManagementManagedDevice -All | Select-Object Id,DeviceName,OperatingSystem,ComplianceState,ManagementAgent,LastSyncDateTime
}

$rows = Get-DeviceData -ModeValue $Mode -Path $InputPath | ForEach-Object {
    [pscustomobject]@{
        DeviceName = $_.DeviceName
        OS = $_.OperatingSystem
        ComplianceState = $_.ComplianceState
        ManagementAgent = $_.ManagementAgent
        LastSync = $_.LastSyncDateTime
    }
}

$rows | Sort-Object ComplianceState,DeviceName | Format-Table -AutoSize
if ($OutputPath) { $rows | Export-Csv -LiteralPath $OutputPath -NoTypeInformation }
