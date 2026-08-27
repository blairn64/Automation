[CmdletBinding()]
param(
    [switch]$Build,
    [switch]$Detach
)

$ErrorActionPreference = 'Stop'
$compose = Join-Path $PSScriptRoot 'compose.monitoring.yml'
$envFile = Join-Path $PSScriptRoot '.env'
$example = Join-Path $PSScriptRoot '.env.example'

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw 'Docker is required. Install Docker Desktop/Engine and retry.'
}

if (-not (Test-Path $envFile)) {
    Copy-Item $example $envFile
    Write-Warning 'Created .env from .env.example. Set a real RabbitMQ password before starting the stack.'
    throw 'Configuration required: edit docker/.env and run again.'
}

$args = @('compose', '--env-file', $envFile, '-f', $compose, 'up')
if ($Detach) { $args += '-d' }
if ($Build) { $args += '--build' }

& docker @args
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host 'Northstar monitoring stack started.'
Write-Host 'Kibana: http://localhost:5601'
Write-Host 'RabbitMQ: http://localhost:15672'
Write-Host 'Elasticsearch: http://localhost:9200'
