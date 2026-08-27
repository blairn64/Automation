[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string]$SubscriptionId,
    [string]$OutputPath = './output/azure-resources.json'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    throw 'Azure CLI (az) is required.'
}

$resources = az resource list --subscription $SubscriptionId --query "[].{name:name,type:type,resourceGroup:resourceGroup,location:location}" --output json | ConvertFrom-Json

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$resources | ConvertTo-Json -Depth 5 | Set-Content -Path $OutputPath -Encoding UTF8
Write-Output "Wrote $(@($resources).Count) resources to $OutputPath"
