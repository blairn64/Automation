# Tooling Guide

## Entra sign-in monitor

`entra/Invoke-TenantSignInMonitor.ps1` is a sanitized demonstration of a multi-tenant sign-in reporting workflow.

It models the following engineering pattern:

1. Authenticate to an authorised Microsoft Graph tenant.
2. Retrieve recent sign-in records.
3. Apply an allowlist-based country check.
4. Normalize findings into objects.
5. Generate a portable HTML report.

The authentication hook is intentionally not populated with credentials, client IDs or certificates. Real authentication material belongs outside source control.

## Exchange privilege audit

`exchange/Get-ExchangePrivilegeAudit.ps1` exports recursive membership of a selected Exchange role group for review.

The tool is read-only: it does not remove or modify membership. This makes the portfolio version suitable for demonstrating privilege-audit logic without embedding a remediation action against a real environment.

## Active Directory lab onboarding

`active-directory/New-LabUser.ps1` demonstrates parameterized directory provisioning with `-WhatIf`/`SupportsShouldProcess` semantics and optional group assignment.

The default distinguished name uses `example.invalid` and the account is created disabled. Use a disposable lab directory when testing.

## Windows session health

`monitoring/Get-WindowsSessionHealth.ps1` parses `qwinsta` output into structured objects and reports session counts as JSON.

The implementation is intentionally generic and does not depend on proprietary monitoring agents or vendor DLLs.

## Design principles

- Parameterize rather than hard-code environment values.
- Fail clearly when required modules are unavailable.
- Keep credentials and certificates outside Git.
- Prefer read-only reporting for security/audit examples.
- Make scripts composable so they can be called by a scheduler, monitoring system or CI job.
