[CmdletBinding()]
param(
    [int]$WarningDays = 60,
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$today = Get-Date
$results = Get-ADUser -Filter * -Properties Enabled,PasswordLastSet,PasswordNeverExpires,msDS-UserPasswordExpiryTimeComputed |
    Where-Object Enabled |
    ForEach-Object {
        $expiry = if ($_.PasswordNeverExpires) { $null } else { [datetime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed') }
        [pscustomobject]@{
            SamAccountName     = $_.SamAccountName
            PasswordLastSet    = $_.PasswordLastSet
            PasswordAgeDays    = if ($_.PasswordLastSet) { [math]::Round(($today - $_.PasswordLastSet).TotalDays,1) } else { $null }
            PasswordNeverExpires = [bool]$_.PasswordNeverExpires
            ExpiryDate         = $expiry
            ExpiringSoon       = [bool]($expiry -and $expiry -le $today.AddDays($WarningDays))
        }
    }

$results | Sort-Object PasswordAgeDays -Descending | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -NoTypeInformation -Path $OutputPath -Encoding utf8 }
