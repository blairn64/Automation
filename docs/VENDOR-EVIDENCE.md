# Vendor evidence index

The portfolio uses the same operational problem spaces as common IT-operations practice, but the code is independently written for this repository. Third-party material is used only as topic inspiration.

## Microsoft 365

- Intune: `m365/intune/Get-IntuneDeviceCompliance.ps1` — compliance inventory with fixture and Graph modes.
- SharePoint: `m365/sharepoint/Get-SharePointSiteInventory.ps1` — site inventory with fixture and Graph modes.
- Teams: `m365/teams/Get-TeamsInventory.ps1` — team inventory with fixture and Graph modes.
- Defender: `security/defender/Get-DefenderIncidentSummary.ps1` — incident triage with fixture and Graph modes.

## Virtualisation

- Hyper-V: `virtualization/Invoke-HyperVInventory.ps1` — VM state, CPU, memory, checkpoints and uptime.
- VMware: `virtualization/Get-VMwareInventory.ps1` — PowerCLI VM, host and datastore inventory.

## Security and monitoring

- Tenable/Nessus-style findings: `security/vulnerability-management/normalise-findings.py` — scanner export to prioritised remediation queue.
- Grafana: `monitoring/grafana/provisioning/dashboards/operations.json` — operational dashboard definition.
- Zabbix: `monitoring/zabbix/templates/enterprise-ops.yaml` — items and triggers for application latency and queue backlog.
- ManageEngine: `monitoring/manageengine/operations/export-schema.json` — endpoint inventory/reporting schema.

## Design rule

Live integrations require authorised credentials at runtime. Fixture modes are the preferred demonstration path for a public repository.