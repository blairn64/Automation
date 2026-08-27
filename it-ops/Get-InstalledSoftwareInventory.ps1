[CmdletBinding()]
param(
    [string]$ComputerName = $env:COMPUTERNAME,
    [string]$Name,
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script = {
    param($SoftwareName)
    $paths = @(
        'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )
    Get-ItemProperty $paths -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -and (-not $SoftwareName -or $_.DisplayName -like "*$SoftwareName*") } |
        Select-Object @{n='ComputerName';e={$env:COMPUTERNAME}},DisplayName,DisplayVersion,Publisher,InstallDate,InstallLocation
}

if ($ComputerName -eq $env:COMPUTERNAME) {
    $results = & $script $Name
} else {
    $results = Invoke-Command -ComputerName $ComputerName -ScriptBlock $script -ArgumentList $Name
}

$results | Sort-Object DisplayName | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -NoTypeInformation -Path $OutputPath -Encoding utf8 }
