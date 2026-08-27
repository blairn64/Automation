Describe 'Northstar telemetry consumer' {
    $root = Split-Path $PSScriptRoot -Parent
    $consumer = Join-Path $root 'monitoring/consumer/rabbitmq_to_ndjson.py'
    $dockerfile = Join-Path $root 'monitoring/Dockerfile.telemetry-consumer'

    It 'has the consumer implementation' {
        Test-Path $consumer | Should -BeTrue
    }

    It 'uses an explicit telemetry queue' {
        (Get-Content $consumer -Raw) | Should -Match 'northstar\.telemetry'
    }

    It 'writes NDJSON output' {
        (Get-Content $consumer -Raw) | Should -Match 'telemetry\.ndjson'
    }

    It 'has a container build definition' {
        Test-Path $dockerfile | Should -BeTrue
        (Get-Content $dockerfile -Raw) | Should -Match 'python:3\.12-slim'
    }
}
