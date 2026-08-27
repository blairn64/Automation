# CV → GitHub Evidence Map

This page maps technical claims to public portfolio evidence. Employment history remains evidence for roles and scale; Northstar and the surrounding Automation portfolio demonstrate transferable implementation and operational practice using synthetic environments only.

## Identity and Microsoft infrastructure

| Skill / claim | Public evidence |
|---|---|
| Active Directory | `labs/northstar-enterprise/architecture/IDENTITY-MODEL.md`, `IDENTITY-AND-OU-OPERATING-MODEL.md` |
| DNS | `scenarios/NS-INC-02-identity-dns.md`, troubleshooting guide |
| Entra ID / Microsoft Graph | Existing identity and Graph automation in this repository |
| Exchange Online | Existing Exchange privilege/audit automation |
| PowerShell | `labs/northstar-enterprise/scripts/` and broader Automation collection |

## Infrastructure and operations

| Skill / claim | Public evidence |
|---|---|
| Windows Server | Northstar server/service catalogue |
| Hyper-V | Northstar enterprise architecture and build order |
| Linux | Existing Bash/Linux tooling in the portfolio |
| IIS | `NS-INC-04-iis-application-outage.md` and scenario helper |
| SQL Server | Server/service catalogue and application dependency model |
| File/Print services | `NS-INC-03-print-outage.md`, FS01/PRN01 operational model |
| DNS/DHCP/TCP/IP | Northstar network and identity troubleshooting model |
| Network segmentation | Network security model and firewall policy matrix |

## Monitoring and security

| Skill / claim | Public evidence |
|---|---|
| SIEM / Elastic | Elastic telemetry architecture and monitoring catalogue |
| Elasticsearch | Telemetry data flow and scenario model |
| Kibana | Telemetry data flow and demo guide |
| RabbitMQ | Messaging path and synthetic workload model |
| ElastAlert 2 | Detection path and incident lifecycle |
| Alert tuning | Monitoring/alert catalogue and RCA lifecycle |
| Incident response | Five controlled incident scenarios |
| Root-cause analysis | Incident lifecycle and evidence packs |

## Automation and engineering

| Skill / claim | Public evidence |
|---|---|
| PowerShell | Health, service, evidence, workload and scenario tooling |
| Python | Existing portfolio applications and messaging work |
| Docker | Existing containerised portfolio work |
| Flask | Existing c0miX application |
| SQL | Existing application/database work plus Northstar dependencies |
| Automation/process improvement | Reusable operational tooling and evidence automation |

## Operational proof path

For the fastest technical walkthrough:

1. Start at `labs/northstar-enterprise/README-PORTFOLIO.md`.
2. Review `architecture/ENTERPRISE-ARCHITECTURE.md`.
3. Review the five scenarios in `scenarios/`.
4. Open `scripts/` to inspect health, evidence and workload automation.
5. Follow a scenario through detection, investigation, recovery and validation.

## Scope note
Public code demonstrates architecture, automation and operational practices. It does not claim to reproduce confidential employer systems or disclose proprietary configurations, data, users, credentials or production records.
