[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('Plan','Validate')]
    [string]$Mode = 'Plan',
    [string]$VmRoot = 'D:\Northstar\VMs',
    [string]$PlanOutput = (Join-Path $PSScriptRoot '..\evidence\provisioning-plan.json')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$vmPlan = @(
    [pscustomobject]@{Name='DC01';Role='AD DS/DNS';Switch='NS-SERVERS';MemoryGB=4;VhdGB=80}
    [pscustomobject]@{Name='DC02';Role='AD DS/DNS';Switch='NS-SERVERS';MemoryGB=4;VhdGB=80}
    [pscustomobject]@{Name='FS01';Role='File Services';Switch='NS-SERVERS';MemoryGB=4;VhdGB=120}
    [pscustomobject]@{Name='PRN01';Role='Print Services';Switch='NS-SERVERS';MemoryGB=2;VhdGB=80}
    [pscustomobject]@{Name='APP01';Role='IIS/Application';Switch='NS-SERVERS';MemoryGB=4;VhdGB=100}
    [pscustomobject]@{Name='SQL01';Role='Database';Switch='NS-SERVERS';MemoryGB=6;VhdGB=160}
    [pscustomobject]@{Name='MQ01';Role='RabbitMQ';Switch='NS-TELEMETRY';MemoryGB=2;VhdGB=60}
    [pscustomobject]@{Name='MON01';Role='Monitoring';Switch='NS-MONITORING';MemoryGB=8;VhdGB=160}
)

if ($Mode -eq 'Validate') {
    $required = 'NS-MGMT','NS-SERVERS','NS-USERS','NS-TELEMETRY','NS-MONITORING'
    $existing = @(Get-VMSwitch -ErrorAction Stop | Select-Object -ExpandProperty Name)
    $missing = @($required | Where-Object { $_ -notin $existing })
    if ($missing) { throw "Missing Hyper-V switches: $($missing -join ', ')" }
}

$directory = Split-Path -Parent $PlanOutput
New-Item -ItemType Directory -Path $directory -Force | Out-Null
$result = [ordered]@{GeneratedUtc=(Get-Date).ToUniversalTime().ToString('o');Mode=$Mode;VmRoot=$VmRoot;VMs=$vmPlan}
$result | ConvertTo-Json -Depth 5 | Set-Content $PlanOutput
$vmPlan | Format-Table -AutoSize

# Deliberately does not create operating systems from unknown media/templates.
# Once local ISO/template paths are supplied, VM creation can be safely added without hard-coded paths or secrets.
