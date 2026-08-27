# IT Operations PowerShell Collection

A collection of original PowerShell administration and troubleshooting utilities inspired by common IT-operations patterns.

These scripts are written for this portfolio and are not copied from third-party articles. They are intentionally safe-by-default, parameterised, and designed for lab or authorised administrative environments.

## Included

- `Get-InactiveADUser.ps1` — report stale AD user accounts.
- `Get-InactiveADComputer.ps1` — report stale AD computer accounts.
- `Get-ADEmptyGroup.ps1` — find non-default empty groups.
- `Get-ADUnlinkedGPO.ps1` — report GPOs without links.
- `Test-ADDomainHealth.ps1` — collect domain-controller health checks.
- `Get-ADPasswordAgeReport.ps1` — report password age and expiry status.
- `Get-InstalledSoftwareInventory.ps1` — inventory Windows software from uninstall registry keys.
- `Get-LocalAdministrator.ps1` — inspect local Administrators group membership.
- `Get-WindowsServiceHealth.ps1` — identify stopped services matching a requested set.
- `Test-DnsRecord.ps1` — test DNS resolution and report timing.

## Design principles

Read-only reporting is preferred. Destructive operations are excluded from this collection unless a future script explicitly exposes `-WhatIf`/`ShouldProcess`.

Environment-specific names, credentials, IP addresses and tenant identifiers must be passed at runtime or kept outside source control.

## Source inspiration

The collection follows the practical IT-operations themes covered by Adam the Automator, particularly Active Directory user/account reporting, groups, GPOs, DNS, troubleshooting, software inventory and reusable PowerShell functions. The implementations here are original portfolio code. citeturn362987view0turn482696search0turn269655search0
