# CV Evidence Matrix

This maps CV claims to specific public artifacts. Production claims remain tied to employment; portfolio artifacts demonstrate the same technical practices using clean-room/synthetic systems.

## Public technical evidence

| CV area | Exact evidence |
| --- | --- |
| Entra ID / Microsoft Graph | [`entra/`](../entra/) sign-in/reporting scripts |
| Exchange Online | [`exchange/`](../exchange/) privilege-audit tooling |
| Active Directory | [`active-directory/`](../active-directory/) + [`it-ops/`](../it-ops/) |
| PowerShell | [`it-ops/`](../it-ops/) 20-script collection + repo tooling |
| Linux | [`linux/`](../linux/) operational checks |
| Azure | [`azure-labs/`](../azure-labs/) administration scenarios |
| REST / authentication | [`api-auth/`](../api-auth/) |
| RabbitMQ / AMQP | [`message-queue/`](../message-queue/) + [`factory-lab/`](../factory-lab/) |
| IT/OT telemetry | [`factory-lab/`](../factory-lab/) |
| 5,000-user enterprise operations | [`enterprise-lab/`](../enterprise-lab/) synthetic estate generators |
| Identity + support correlation | [`enterprise-lab/join-identity-support.py`](../enterprise-lab/join-identity-support.py) |
| IIS application support | [`windows/iis/Get-IisHealthReport.ps1`](../windows/iis/Get-IisHealthReport.ps1) |
| SQL Server diagnostics | [`sql/health/`](../sql/health/) |
| SAP-style integration | [`enterprise-lab/integrations/sap-style/`](../enterprise-lab/integrations/sap-style/) |
| Siemens/PLC-style OT boundary | [`enterprise-lab/ot/`](../enterprise-lab/ot/) |
| NoSQL / MongoDB | [`evidence-labs/nosql/mongo-demo.py`](../evidence-labs/nosql/mongo-demo.py) |
| Power BI / operational reporting | [`evidence-labs/power-bi/`](../evidence-labs/power-bi/) + `OperationalKPIs.dax` |
| Elastic | [`elastics-SIEM`](../../elastics-SIEM) + [`monitoring/elastic/`](../monitoring/elastic/) |
| Wazuh | [`evidence-labs/wazuh/`](../evidence-labs/wazuh/) + `rules/local-rules.xml` |
| Grafana | [`evidence-labs/observability/grafana/`](../evidence-labs/observability/grafana/) + dashboard definition |
| Zabbix | [`evidence-labs/observability/zabbix/`](../evidence-labs/observability/zabbix/) |
| ManageEngine | [`evidence-labs/observability/manageengine/`](../evidence-labs/observability/manageengine/) |
| Networking | [`evidence-labs/networking/`](../evidence-labs/networking/) + `test-network-path.ps1` |
| VMware / Hyper-V operational work | [`virtualization/`](../virtualization/) |
| Vulnerability management | [`security/vulnerability-management/`](../security/vulnerability-management/) |
| Service desk | [`service-desk/`](../service-desk/) |
| Incident response / RCA | [`incident-scenarios/`](../incident-scenarios/) |
| Docker | [`message-queue/`](../message-queue/) + [`c0miX`](../../c0miX) |
| Flask / Python | [`c0miX`](../../c0miX) |

## Professional-experience evidence

These are genuine employment claims supported by the CV/work history. The public labs intentionally model the same classes of systems without publishing employer configuration or data:

- Supporting thousands of users
- Global multi-site manufacturing operations
- Factory production subnets and production servers
- IIS-hosted production applications
- SQL Server and SAP support
- Siemens PLC-connected environments
- Industrial scales, sensor data and production metrics
- Microsoft 365, Intune, SharePoint and Teams administration
- Microsoft Defender and SIEM incident response
- Tenable/Nessus vulnerability management
- VMware and Hyper-V in production
- Enterprise firewall/VPN/DNS/DHCP administration
- Zabbix, Grafana and ManageEngine in production
- Escalation, troubleshooting and root-cause analysis

## Evidence rule

A public implementation proves technical capability and provides an interviewable artifact. It does not claim that the lab is the same production environment used in employment.
