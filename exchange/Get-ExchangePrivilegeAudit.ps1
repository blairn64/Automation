[CmdletBinding()]
param(
    [string]$RoleGroup = 'Organization Management',
    [string]$OutputPath = './output/exchange-privilege-audit.csv'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Run this only against an Exchange environment you are authorised to administer.
# The script intentionally does not contain connection credentials or tenant data.

if (-not (Get-Command Get-RoleGroupMember -ErrorAction SilentlyContinue)) {
    throw 'ExchangeOnlineManagement cmdlets are not available. Install/import the module in your authorised lab.'
}

$members = Get-RoleGroupMember -Identity $RoleGroup -Recursive |
    Select-Object Name, RecipientType, PrimarySmtpAddress

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force | Out-Null }

$members | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

Write-Output "Exported $(@($members).Count) members from '$RoleGroup' to $OutputPath"
