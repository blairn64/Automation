# Adam the Automator IT-Ops Crosswalk

This document records how external IT-operations topics were used as inspiration when extending this portfolio. The code in this repository is independently written for the portfolio and is not copied from the referenced articles.

## Topic crosswalk

| ATA topic | Portfolio implementation | CV capability demonstrated |
| --- | --- | --- |
| Active Directory scripts | `it-ops/` AD reporting and health utilities | Active Directory, PowerShell automation |
| AD health checks | `it-ops/Test-ADDomainHealth.ps1`, `it-ops/Get-ADReplicationHealth.ps1` | Domain-controller troubleshooting, replication |
| AD sites / links / subnets | `it-ops/Get-ADSiteTopology.ps1` | Multi-site infrastructure, network-aware AD administration |
| AD database | `it-ops/Get-ADDatabaseSize.ps1` | Windows Server / AD operations |
| SPNs | `it-ops/Get-ADDuplicateSPN.ps1` | Identity troubleshooting, Kerberos/SPN hygiene |
| DNS troubleshooting | `it-ops/Test-DnsRecord.ps1`, `it-ops/Test-DnsRecordHealth.ps1` | DNS, TCP diagnostics, layered troubleshooting |
| Services | `it-ops/Get-WindowsServiceHealth.ps1`, `it-ops/Test-RemoteService.ps1` | Windows operations, remote troubleshooting |
| Scheduled tasks | `it-ops/Get-ScheduledTaskHealth.ps1` | Job health / operational automation |
| Software inventory | `it-ops/Get-InstalledSoftwareInventory.ps1` | Asset inventory, endpoint operations |
| Certificates / IIS | `it-ops/Get-CertificateExpiryReport.ps1`, `it-ops/Get-IISBindingAudit.ps1` | IIS, certificates, application support |
| Reusable reporting | `it-ops/New-HtmlInventoryReport.ps1` | Operational reporting / automation |

## Source material

The collection was cross-checked against the following Adam the Automator IT-operations articles and themes:

- Active Directory automation scripts: https://adamtheautomator.com/active-directory-scripts/
- Active Directory sites: https://adamtheautomator.com/active-directory-site/
- DNS troubleshooting with PowerShell: https://adamtheautomator.com/troubleshoot-dns-issues-powershell/
- IIS certificate and binding automation: https://adamtheautomator.com/iis-certificate-request/

The source material influenced **what kinds of administrative problems to cover**, not the code implementation. Any production claims in the CV remain claims about professional experience; these files are public demonstrations using clean-room or synthetic environments.
