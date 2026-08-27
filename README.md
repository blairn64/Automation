# Infrastructure Automation

[![PowerShell](https://img.shields.io/badge/PowerShell-automation-5391FE?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Microsoft Graph](https://img.shields.io/badge/Microsoft%20Graph-API-5E5CE6)](https://learn.microsoft.com/graph/)
[![Security](https://img.shields.io/badge/focus-defensive%20operations-2ea44f)](#scope)

Practical PowerShell automation for identity, messaging, directory administration and infrastructure monitoring.

The repository is intentionally **portfolio-safe**: examples use placeholders and generic lab targets rather than customer or production configuration.

## Scope

| Area | Examples | Main technologies |
|---|---|---|
| Identity | Sign-in reporting and security checks | PowerShell, Microsoft Graph, Entra ID |
| Messaging | Privileged role-group auditing | Exchange Online PowerShell |
| Directory | Lab user provisioning | Active Directory PowerShell |
| Monitoring | Windows session health | PowerShell, Windows tooling |

## Repository layout

```text
entra/
  Invoke-TenantSignInMonitor.ps1
exchange/
  Get-ExchangePrivilegeAudit.ps1
active-directory/
  New-LabUser.ps1
monitoring/
  Get-WindowsSessionHealth.ps1
shared/
docs/
  TOOLING.md
  SECURITY.md
  ROADMAP.md
```

## Engineering approach

The scripts favour parameterization, structured output, clear failure modes and safe defaults. Security/audit tooling is read-only where practical, and potentially destructive operations are avoided in the public examples.

## Safety

Do not add:

- employer or client names
- real usernames or email addresses
- tenant/subscription/resource IDs
- internal domains, URLs, hostnames or IP addresses
- passwords, API keys, access tokens, private keys or certificates
- copied ticket content or customer data
- proprietary DLLs, binaries or vendor material

See [`docs/SECURITY.md`](docs/SECURITY.md) before publishing changes.

## Provenance

Some tools are sanitized portfolio reconstructions based on general infrastructure automation patterns and professional experience. They are **not** copies of a production environment.
