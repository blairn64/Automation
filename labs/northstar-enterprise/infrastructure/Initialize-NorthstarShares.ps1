[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Root = 'D:\NorthstarShares'
)

$ErrorActionPreference = 'Stop'
$Departments = 'Finance','Engineering','Operations','HR','IT','Plant-East','Plant-West'

New-Item -ItemType Directory -Path $Root -Force | Out-Null

foreach ($department in $Departments) {
    $path = Join-Path $Root $department
    if ($PSCmdlet.ShouldProcess($path, 'Create department share folder')) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
        $shareName = "NS-$department"
        if (-not (Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue)) {
            New-SmbShare -Name $shareName -Path $path -FullAccess 'NORTHSTAR\Domain Admins' -ChangeAccess "NORTHSTAR\GG-$department-Modify" | Out-Null
        }
    }
}

Write-Host 'Northstar share structure created. Apply production-style NTFS ACLs from the AD groups documented in active-directory/README.md.'
