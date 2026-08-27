[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$VmRoot = 'D:\Northstar\VMs',
    [string[]]$Switches = @('NS-MGMT','NS-SERVERS','NS-USERS','NS-TELEMETRY','NS-MONITORING'),
    [switch]$CreateDirectories
)

$plan = @(
    [pscustomobject]@{ Name='DC01'; MemoryGB=4; VhdGB=80; Switch='NS-SERVERS'; Role='AD DS/DNS' }
    [pscustomobject]@{ Name='DC02'; MemoryGB=4; VhdGB=80; Switch='NS-SERVERS'; Role='AD DS/DNS' }
    [pscustomobject]@{ Name='FS01'; MemoryGB=4; VhdGB=120; Switch='NS-SERVERS'; Role='File Services' }
    [pscustomobject]@{ Name='PRN01'; MemoryGB=2; VhdGB=80; Switch='NS-SERVERS'; Role='Print Services' }
    [pscustomobject]@{ Name='APP01'; MemoryGB=4; VhdGB=100; Switch='NS-SERVERS'; Role='IIS/Application' }
    [pscustomobject]@{ Name='SQL01'; MemoryGB=6; VhdGB=160; Switch='NS-SERVERS'; Role='Database' }
    [pscustomobject]@{ Name='MQ01'; MemoryGB=2; VhdGB=60; Switch='NS-TELEMETRY'; Role='RabbitMQ' }
    [pscustomobject]@{ Name='MON01'; MemoryGB=8; VhdGB=160; Switch='NS-MONITORING'; Role='Elastic/Monitoring' }
)

$plan | Add-Member -NotePropertyName GeneratedUtc -NotePropertyValue (Get-Date).ToUniversalTime().ToString('o') -PassThru |
    Select-Object Name,Role,MemoryGB,VhdGB,Switch,GeneratedUtc |
    Format-Table -AutoSize

if ($CreateDirectories) {
    foreach ($vm in $plan) {
        $path = Join-Path $VmRoot $vm.Name
        if ($PSCmdlet.ShouldProcess($path,'Create VM working directory')) {
            New-Item -ItemType Directory -Path $path -Force | Out-Null
        }
    }
}

# This script intentionally creates a reviewed plan and optional working directories.
# VM creation/import should be added only after local ISO/template paths are defined.
