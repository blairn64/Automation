[CmdletBinding()]
param(
    [string]$RoleGroup = 'Organization Management',
    [string]$OutputPath = './output/exchange-privilege-audit.csv'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command Get-RoleGroupMember -ErrorAction SilentlyContinue)) {
    throw 'Exchange Online Management cmdlets are not available. Install/import the module in an authorised lab.'
}

$members = @(Get-RoleGroupMember -Identity $RoleGroup -Recursive |
    Select-Object Name, RecipientType, PrimarySmtpAddress)

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}

$members | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8

[pscustomobject]@{
    RoleGroup = $RoleGroup
    MemberCount = $members.Count
    OutputPath = (Resolve-Path -LiteralPath $OutputPath).Path
}
