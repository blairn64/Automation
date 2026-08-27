[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$Name,

    [Parameter(Mandatory)]
    [ValidateSet('CORP-USERS','SERVERS','INFRA-MGMT','DMZ','PRINT-IOT','MONITORING','OT','GUEST','NET-MGMT')]
    [string]$Network,

    [ValidateRange(1, 64)]
    [int]$MemoryGB = 4,

    [ValidateRange(1, 16)]
    [int]$Generation = 2,

    [string]$VhdPath = "$env:PUBLIC\Documents\Hyper-V\Virtual hard disks\$Name.vhdx",

    [string]$SwitchPrefix = 'NS'
)

$ErrorActionPreference = 'Stop'
$SwitchName = "$SwitchPrefix-$Network"

if (Get-VM -Name $Name -ErrorAction SilentlyContinue) {
    throw "VM already exists: $Name"
}

if (-not (Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue)) {
    throw "Required switch does not exist: $SwitchName. Run New-NorthstarNetwork.ps1 first."
}

$VMPath = Split-Path -Path $VhdPath -Parent
if (-not (Test-Path $VMPath)) {
    New-Item -ItemType Directory -Path $VMPath -Force | Out-Null
}

if ($PSCmdlet.ShouldProcess($Name, "Create Hyper-V VM on $SwitchName")) {
    New-VM -Name $Name -Generation $Generation -MemoryStartupBytes (${MemoryGB}GB) -NoVHD | Out-Null
    New-VHD -Path $VhdPath -Dynamic -SizeBytes 80GB | Out-Null
    Add-VMHardDiskDrive -VMName $Name -Path $VhdPath
    Connect-VMNetworkAdapter -VMName $Name -SwitchName $SwitchName
    Set-VMMemory -VMName $Name -DynamicMemoryEnabled $true -MinimumBytes 1GB -StartupBytes (${MemoryGB}GB) -MaximumBytes (${MemoryGB}GB)

    # OPNsense on Hyper-V requires Secure Boot to be disabled.
    if ($Name -like '*FW*' -or $Name -like '*OPNSENSE*') {
        Set-VMFirmware -VMName $Name -EnableSecureBoot Off
    }
}

Write-Host "Created $Name on $SwitchName. Attach installation media and configure the guest according to the relevant runbook."
