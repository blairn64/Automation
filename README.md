# Infrastructure Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-automation-5391FE?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Microsoft Graph](https://img.shields.io/badge/Microsoft%20Graph-API-5E5CE6)](https://learn.microsoft.com/graph/)
[![CI](https://img.shields.io/badge/CI-PSScriptAnalyzer-2ea44f)](.github/workflows/powershell.yml)

Practical automation across identity, Microsoft 365, directory services, Windows monitoring, Linux administration, Azure, REST APIs, message queues and synthetic manufacturing telemetry.

This repository turns infrastructure problem-solving patterns into **sanitized, reproducible portfolio examples**. It contains no customer or production configuration.

## What this demonstrates

- PowerShell automation and defensive scripting
- Microsoft Graph and Entra ID integration patterns
- Exchange Online auditing
- Active Directory administration
- Windows and Linux operational checks
- Azure administration and resource reporting
- REST API authentication boundaries
- RabbitMQ-compatible asynchronous processing
- Synthetic factory telemetry and IT/OT-style data flow
- Configuration and secret separation
- CI/static analysis with PSScriptAnalyzer

## Repository layout

```text
entra/              Microsoft Graph / Entra reporting
exchange/            Exchange Online audit tooling
active-directory/    Directory administration examples
monitoring/          Windows session and health checks
linux/               Bash administration utilities
api-auth/            REST authentication patterns
message-queue/       RabbitMQ-compatible producer/consumer lab
factory-lab/         Synthetic manufacturing telemetry lab
azure-labs/          AZ-104-aligned administration exercises
shared/              Example configuration
.github/             CI quality checks
docs/                Technical notes and portfolio guidance
```

## Highlighted projects

### Infrastructure automation
Small PowerShell tools turn repeatable identity, directory and monitoring tasks into parameterized commands with structured output and safe defaults.

### Factory Telemetry Lab
`factory-lab/` models a production-style telemetry path without touching industrial equipment: synthetic sensor events → AMQP queue → processing/validation → operational output.

### Azure Administration Labs
`azure-labs/` contains administrator-focused exercises around resource inventory, networking, VM operations, storage and monitoring. They are intentionally generic and use placeholders rather than real subscription configuration.

### APIs and queues
`api-auth/` demonstrates authenticated REST calls without storing tokens. `message-queue/` demonstrates producer/consumer separation, durable queues and acknowledgement behaviour.

## Engineering approach

The examples favour explicit parameters, predictable output, useful errors and safe defaults. Audit tooling is read-only where practical. Administrative changes use explicit parameters and `ShouldProcess` where appropriate.

## Safety

Do not add:

- employer or client names
- real usernames or email addresses
- tenant, subscription or resource IDs
- internal domains, URLs, hostnames or IP addresses
- passwords, API keys, access tokens, private keys or certificates
- copied ticket content or customer data
- proprietary DLLs, binaries or vendor material
- real industrial control addresses, PLC credentials or production telemetry

See [`docs/SECURITY.md`](docs/SECURITY.md) before publishing changes.

## Provenance

Some tools are sanitized portfolio reconstructions based on general infrastructure automation patterns and professional experience. They are not copies of a production environment.
