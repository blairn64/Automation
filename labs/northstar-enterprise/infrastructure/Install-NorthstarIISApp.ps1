<#
.SYNOPSIS
Builds a synthetic internal Northstar IIS application host.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$SiteName='Northstar-Operations',
    [string]$Path='C:\Northstar\OperationsPortal',
    [int]$Port=8080
)

Install-WindowsFeature Web-Server -IncludeManagementTools
New-Item -ItemType Directory -Path $Path -Force | Out-Null

$html = @"
<!doctype html>
<html><head><title>Northstar Operations Portal</title></head>
<body><h1>Northstar Manufacturing Group</h1><p>Synthetic internal operations portal.</p><p>Status: Healthy</p></body></html>
"@
Set-Content -Path (Join-Path $Path 'index.html') -Value $html -Encoding UTF8

Import-Module WebAdministration
if (Get-Website -Name $SiteName -ErrorAction SilentlyContinue) { Remove-Website -Name $SiteName }
New-Website -Name $SiteName -PhysicalPath $Path -Port $Port -Force
Write-Host "IIS site $SiteName available on port $Port" -ForegroundColor Green
