[CmdletBinding()]
param(
    [ValidateSet('HQ','PLANT-EAST','PLANT-WEST')]
    [string]$Site = 'HQ',
    [int]$Count = 5,
    [string]$VmPath = 'D:\Northstar\VMs',
    [string]$TemplateVhd = 'D:\Northstar\Templates\WindowsClient.vhdx',
    [switch]$Create
)

$ErrorActionPreference = 'Stop'

$prefix = switch ($Site) {
    'HQ' { 'HQ-CL' }
    'PLANT-EAST' { 'PE-CL' }
    'PLANT-WEST' { 'PW-CL' }
}

$results = for ($i = 1; $i -le $Count; $i++) {
    $name = '{0}{1:d2}' -f $prefix, $i
    [pscustomobject]@{ Name = $name; Site = $Site; Role = 'Corporate client'; Status = if ($Create) { 'Create requested' } else { 'Plan only' } }
}

$results | Format-Table -AutoSize

if ($Create) {
    if (-not (Test-Path $TemplateVhd)) { throw "Template VHD not found: $TemplateVhd" }
    foreach ($client in $results) {
        $vmFolder = Join-Path $VmPath $client.Name
        New-Item -ItemType Directory -Path $vmFolder -Force | Out-Null
        $vhd = Join-Path $vmFolder "$($client.Name).vhdx"
        Copy-Item $TemplateVhd $vhd -Force
        New-VM -Name $client.Name -Generation 2 -MemoryStartupBytes 4GB -VHDPath $vhd | Out-Null
        Set-VMProcessor -VMName $client.Name -Count 2
    }
}
