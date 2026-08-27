# Infrastructure Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-automation-5391FE?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Microsoft Graph](https://img.shields.io/badge/Microsoft%20Graph-API-5E5CE6)](https://learn.microsoft.com/graph/)
[![CI](https://img.shields.io/badge/CI-PSScriptAnalyzer-2ea44f)](.github/workflows/powershell.yml)

Practical automation across identity, Microsoft 365, directory services, Windows monitoring, Linux administration, REST APIs and message queues.

This repository turns real-world infrastructure problem-solving patterns into **sanitized, reproducible portfolio examples**. It contains no customer or production configuration.

## What this demonstrates

- PowerShell automation and defensive scripting
- Microsoft Graph and Entra ID integration patterns
- Exchange Online auditing
- Active Directory administration
- Windows and Linux operational checks
- REST API authentication patterns
- RabbitMQ-compatible asynchronous processing
- Configuration and secret separation
- CI/static analysis with PSScriptAnalyzer

## Repository layout

```text
entra/          Microsoft Graph / Entra reporting
exchange/       Exchange Online audit tooling
active-directory/  Directory administration examples
monitoring/     Windows session and health checks
linux/          Bash administration utilities
api-auth/       REST authentication patterns
message-queue/  RabbitMQ-compatible producer/consumer lab
shared/         Example configuration
.github/        CI quality checks
docs/           Technical notes and roadmap
```

## Tooling highlights

### Identity
`entra/Invoke-TenantSignInMonitor.ps1` produces a sanitized HTML report for successful sign-ins outside a configured country allowlist. Authentication is intentionally supplied at runtime rather than stored in the repository.

### Microsoft 365 / Exchange
`exchange/Get-ExchangePrivilegeAudit.ps1` recursively audits an Exchange role group and exports a reviewable CSV. It is deliberately read-only.

### Active Directory
`active-directory/New-LabUser.ps1` demonstrates parameterized user preparation with `ShouldProcess` support and optional group assignment.

### Monitoring
`monitoring/Get-WindowsSessionHealth.ps1` turns Windows Terminal Services session information into structured JSON suitable for automation or a monitoring pipeline.

### Linux
`linux/health-check.sh` provides a lightweight SSH/cron-friendly host health report covering uptime, load, memory, storage and failed systemd units.

### APIs and queues
`api-auth/` demonstrates bearer-token API calls without embedding credentials. `message-queue/` contains a small publisher/consumer pair and a local RabbitMQ lab definition.

## Engineering approach

The examples favour explicit parameters, predictable output, useful errors and safe defaults. The intent is to show how repetitive infrastructure work can be converted into small, maintainable tools.

## Safety

Do not add:

- employer or client names
- real usernames or email addresses
- tenant, subscription or resource IDs
- internal domains, URLs, hostnames or IP addresses
- passwords, API keys, access tokens, private keys or certificates
- copied ticket content or customer data
- proprietary DLLs, binaries or vendor material

See [`docs/SECURITY.md`](docs/SECURITY.md) before publishing changes.

## Provenance

Some tools are sanitized portfolio reconstructions based on general infrastructure automation patterns and professional experience. They are not copies of a production environment.
