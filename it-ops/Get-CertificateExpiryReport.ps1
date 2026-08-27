[CmdletBinding()]
param(
    [ValidateRange(1,3650)]
    [int]$Days = 60,
    [ValidateSet('CurrentUser','LocalMachine')]
    [string]$Store = 'LocalMachine',
    [string]$OutputPath
)

$location = "Cert:\$Store\My"
$cutoff = (Get-Date).AddDays($Days)

$results = Get-ChildItem -Path $location -ErrorAction Stop |
    Where-Object { $_.NotAfter -le $cutoff } |
    Sort-Object NotAfter |
    Select-Object Subject, Issuer, Thumbprint, NotBefore, NotAfter,
        @{Name='DaysRemaining';Expression={ [math]::Floor(($_.NotAfter - (Get-Date)).TotalDays) }},
        @{Name='HasPrivateKey';Expression={ $_.HasPrivateKey }}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
