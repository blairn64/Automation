# Adam the Automator IT-Ops Crosswalk

This document records how external IT-operations topics were used as inspiration when extending this portfolio. The code in this repository is independently written for the portfolio and is not copied from the referenced articles.

## Topic crosswalk

| ATA / IT-ops topic | Portfolio implementation | CV capability demonstrated |
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
| Intune endpoint administration | `m365/intune/Get-IntuneDeviceCompliance.ps1` | Intune, device compliance, Graph automation |
| SharePoint inventory | `m365/sharepoint/Get-SharePointSiteInventory.ps1` | SharePoint administration, Graph automation |
| Teams inventory | `m365/teams/Get-TeamsInventory.ps1` | Teams administration, Graph automation |
| Defender incident review | `security/defender/Get-DefenderIncidentSummary.ps1` | Defender, incident triage, security operations |
| Hyper-V management | `virtualization/Invoke-HyperVInventory.ps1` | Hyper-V, VM operations, PowerShell |
| VMware / PowerCLI | `virtualization/Get-VMwareInventory.ps1` | VMware, PowerCLI, infrastructure inventory |
| Vulnerability workflow | `security/vulnerability-management/normalise-findings.py` | Tenable/Nessus-style processing, risk prioritisation |
| Grafana operations | `monitoring/grafana/provisioning/dashboards/operations.json` | Dashboarding, operational observability |
| Zabbix operations | `monitoring/zabbix/templates/enterprise-ops.yaml` | Monitoring, triggers, infrastructure health |
| ManageEngine operations | `monitoring/manageengine/operations/export-schema.json` | Endpoint inventory / operational reporting |

## Portfolio-built themes from our work

The broader portfolio extends these IT-ops patterns into the areas reflected in the CV: Microsoft Graph/Entra, Exchange, Azure, Linux, RabbitMQ/AMQP, SQL, Elastic, IT/OT telemetry, factory simulation, service-desk correlation and incident response.

## Source material

The collection was cross-checked against Adam the Automator IT-operations articles and themes including Active Directory automation, AD sites, DNS troubleshooting, IIS/certificates, Hyper-V and PowerShell administration.

Reference material:
- https://adamtheautomator.com/active-directory-scripts/
- https://adamtheautomator.com/active-directory-site/
- https://adamtheautomator.com/troubleshoot-dns-issues-powershell/
- https://adamtheautomator.com/iis-certificate-request/
- https://adamtheautomator.com/hyper-v-powershell/
- https://adamtheautomator.com/powercli-tutorial/

The source material influenced **what administrative problems to cover**, not the code implementation. Public portfolio artifacts use synthetic or clean-room environments; employment claims remain claims about professional experience.
