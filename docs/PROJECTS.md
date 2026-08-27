# Portfolio Project Guide

This repository collects small, focused infrastructure automation tools. Each tool is deliberately narrow, documented, and safe to run only in systems the operator is authorised to administer.

## Identity and cloud automation

### Tenant sign-in monitor
`entra/Invoke-TenantSignInMonitor.ps1` demonstrates Microsoft Graph sign-in collection across a configurable set of tenants, filtering successful sign-ins against a country allowlist and producing an HTML report.

The portfolio version requires the operator to provide Graph application authentication details through parameters or environment variables. No tenant identifiers, certificates, users or mailboxes are embedded in source control.

### Exchange privilege audit
`exchange/Get-ExchangePrivilegeAudit.ps1` inventories members of a configurable Exchange role group and exports a reviewable CSV. The tool is intentionally audit-only; it does not remove or change permissions.

### Active Directory user preparation
`active-directory/New-LabUser.ps1` demonstrates safe parameterized user creation with `-WhatIf`/`ShouldProcess` support and optional group assignment. It defaults to a deliberately fake lab OU.

## Monitoring

### Windows session health
`monitoring/Get-WindowsSessionHealth.ps1` wraps `qwinsta`, normalizes session information and emits JSON suitable for monitoring pipelines or further automation.

## Design principles

- Prefer read-only/audit operations where possible.
- Make destructive actions explicit and support PowerShell `ShouldProcess` where appropriate.
- Keep credentials and environment-specific configuration outside Git.
- Emit structured output for reuse by other tools.
- Fail clearly when required modules, permissions or connectivity are unavailable.
