# Infrastructure Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-automation-5391FE?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Microsoft Graph](https://img.shields.io/badge/Microsoft%20Graph-API-5E5CE6)](https://learn.microsoft.com/graph/)
[![CI](https://img.shields.io/badge/CI-PSScriptAnalyzer-2ea44f)](.github/workflows/powershell.yml)

Practical automation across identity, Microsoft 365, directory services, Windows and Linux administration, Azure, REST APIs, message queues and synthetic manufacturing telemetry.

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

## Portfolio projects

### Factory Telemetry Lab
`factory-lab/` models a production-style telemetry path using synthetic sensor events, an AMQP queue, a processing worker, validation and anomaly checks. It deliberately does not connect to real PLCs or plant networks.

### Azure Administration Labs
`azure-labs/` contains administrator-focused scenarios around resource inventory, networking, VM operations, storage and monitoring. The material is generic and uses placeholders rather than real subscription configuration.

### Identity and Microsoft 365 Automation
`entra/`, `exchange/` and `active-directory/` contain reporting, audit and lab administration examples. Credentials and tenant-specific values are supplied at runtime.

### Operations and Integration
`monitoring/`, `linux/`, `api-auth/` and `message-queue/` cover Windows/Linux health checks, REST authentication and asynchronous processing.

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

## Engineering approach

The examples favour explicit parameters, predictable output, useful errors and safe defaults. Audit tooling is read-only where practical. Administrative changes use explicit parameters and `ShouldProcess` where appropriate.

## Safety

Do not add employer or client names, real usernames or email addresses, tenant/subscription/resource IDs, internal domains or URLs, hostnames or IP addresses, credentials, private keys, copied ticket content, customer data, proprietary binaries, real industrial-control addresses or production telemetry.

See [`docs/SECURITY.md`](docs/SECURITY.md) before publishing changes.

## Provenance

Some tools are sanitized portfolio reconstructions based on general infrastructure automation patterns and professional experience. They are not copies of a production environment.
