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
- `Get-WindowsServiceHealth.ps1` — inspect selected Windows services locally or remotely.
- `Test-DnsRecord.ps1` — test DNS resolution and report timing.

## Example usage

```powershell
.\Get-InactiveADUser.ps1 -InactiveDays 90 -OutputPath .\inactive-users.csv
.\Get-InactiveADComputer.ps1 -InactiveDays 120
.\Get-ADPasswordAgeReport.ps1 -WarningDays 30 -OutputPath .\password-age.csv
.\Get-InstalledSoftwareInventory.ps1 -ComputerName PC01 -Name 'Visual C++'
.\Get-LocalAdministrator.ps1 -ComputerName PC01
.\Get-WindowsServiceHealth.ps1 -ComputerName PC01 -ServiceName WinRM,EventLog
.\Test-DnsRecord.ps1 -Name app.example.test -Type A
```

## Design principles

Read-only reporting is preferred. Destructive operations are excluded from this collection unless a future script explicitly exposes `-WhatIf`/`ShouldProcess`.

Environment-specific names, credentials, IP addresses and tenant identifiers must be passed at runtime or kept outside source control.

## Source inspiration

The collection is informed by the practical IT-operations themes covered by Adam the Automator, including Active Directory account reporting, groups, GPOs, DNS, troubleshooting, software inventory, onboarding and reusable PowerShell functions. The implementations here are independently written for this portfolio.

Reference material:
- https://adamtheautomator.com/active-directory-scripts/
- https://adamtheautomator.com/powershell-list-installed-software/
- https://adamtheautomator.com/powershell-onboarding-script/
- https://adamtheautomator.com/powershell-modules/
