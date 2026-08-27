[CmdletBinding()]
param(
    [string]$RulePath = (Join-Path $PSScriptRoot '..\elastalert2\rules'),
    [string]$ConfigPath = (Join-Path $PSScriptRoot '..\elastalert2\config\config.yaml')
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $RulePath)) { throw "Rule path not found: $RulePath" }
if (-not (Test-Path $ConfigPath)) { throw "Config path not found: $ConfigPath" }

$rules = Get-ChildItem -Path $RulePath -Recurse -File -Include *.yaml, *.yml
if (-not $rules) { throw "No ElastAlert rules found in $RulePath" }

foreach ($rule in $rules) {
    Write-Host "Testing rule: $($rule.FullName)"
    $args = @('--rm', '-v', "${ConfigPath}:/opt/elastalert/config.yaml:ro", '-v', "${RulePath}:/opt/elastalert/rules:ro", '--entrypoint', 'elastalert-test-rule', 'jertel/elastalert2:2', '--config', '/opt/elastalert/config.yaml', "/opt/elastalert/rules/$($rule.Name)")
    & docker @args
    if ($LASTEXITCODE -ne 0) { throw "ElastAlert rule test failed: $($rule.Name)" }
}
