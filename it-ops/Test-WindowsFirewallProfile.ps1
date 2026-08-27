[CmdletBinding()]
param(
    [string]$OutputPath
)

$profiles = Get-NetFirewallProfile -ErrorAction Stop |
    Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction,
        AllowInboundRules, AllowLocalFirewallRules

$profiles | Format-Table -AutoSize
if ($OutputPath) { $profiles | Export-Csv -Path $OutputPath -NoTypeInformation }
