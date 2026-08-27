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
- `Get-ADDatabaseSize.ps1` — inventory NTDS database paths and sizes across domain controllers.
- `Get-InstalledSoftwareInventory.ps1` — inventory Windows software from uninstall registry keys.
- `Get-LocalAdministrator.ps1` — inspect local Administrators group membership.
- `Get-WindowsServiceHealth.ps1` — inspect selected Windows services locally or remotely.
- `Get-ScheduledTaskHealth.ps1` — review scheduled-task state and last results.
- `Get-RecentSystemEvents.ps1` — summarize recent Windows event-log entries.
- `Get-WindowsDiskHealth.ps1` — report local disk capacity and free-space thresholds.
- `Get-WindowsUptime.ps1` — report host uptime and long-running systems.
- `Get-TopProcesses.ps1` — identify processes using the most CPU time in a sample.
- `Test-RemoteService.ps1` — check named services across remote hosts.
- `Test-HostConnectivity.ps1` — combine ICMP and TCP reachability checks.
- `Test-WindowsFirewallProfile.ps1` — inspect Windows Firewall profile state.
- `Get-CertificateExpiryReport.ps1` — report certificates approaching expiry.
- `Test-DnsRecord.ps1` — test DNS resolution and report timing.
- `New-HtmlInventoryReport.ps1` — turn collected objects into a portable HTML report.

## Example usage

```powershell
.\Get-InactiveADUser.ps1 -InactiveDays 90 -OutputPath .\inactive-users.csv
.\Get-ADDatabaseSize.ps1 -OutputPath .\ad-database.csv
.\Get-ADPasswordAgeReport.ps1 -WarningDays 30 -OutputPath .\password-age.csv
.\Get-ScheduledTaskHealth.ps1 -ComputerName PC01
.\Get-RecentSystemEvents.ps1 -Hours 24 -LogName System
.\Get-WindowsDiskHealth.ps1 -ComputerName PC01 -MinimumFreePercent 15
.\Get-WindowsUptime.ps1 -ComputerName PC01
.\Get-TopProcesses.ps1 -Top 10
.\Test-RemoteService.ps1 -ComputerName PC01 -ServiceName WinRM,EventLog
.\Test-HostConnectivity.ps1 -ComputerName PC01 -Port 443
.\Test-WindowsFirewallProfile.ps1
.\Get-CertificateExpiryReport.ps1 -Days 60
.\Test-DnsRecord.ps1 -Name app.example.test -Type A
```

## Design principles

Read-only reporting is preferred. Destructive operations are excluded from this collection unless a future script explicitly exposes `-WhatIf`/`ShouldProcess`.

Environment-specific names, credentials, IP addresses and tenant identifiers must be passed at runtime or kept outside source control.

## Source inspiration

The collection is informed by the practical IT-operations themes covered by Adam the Automator, including Active Directory account reporting, groups, GPOs, DNS, troubleshooting, software inventory, onboarding, services, AD health and reusable PowerShell functions. The implementations here are independently written for this portfolio.

Reference material:
- https://adamtheautomator.com/active-directory-scripts/
- https://adamtheautomator.com/powershell-list-installed-software/
- https://adamtheautomator.com/powershell-onboarding-script/
- https://adamtheautomator.com/powershell-modules/
- https://adamtheautomator.com/active-directory-health-check-2/
- https://adamtheautomator.com/active-directory-database/
- https://adamtheautomator.com/powershell-start-service/
- https://adamtheautomator.com/windows-certificate-manager/
