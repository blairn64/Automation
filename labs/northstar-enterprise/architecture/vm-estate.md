# Northstar Enterprise VM Estate

Northstar Manufacturing Group is a synthetic, disposable enterprise environment. Names, users, systems and addressing are fictional.

## Deployment profiles

| Profile | Purpose | Suggested VMs |
|---|---|---|
| CORE | Identity and admin | NS-FW01, HQ-DC01, HQ-DC02, HQ-MGMT01 |
| CORPORATE | Core business services | CORE + HQ-FS01, HQ-PRN01, HQ-SQL01, HQ-APP01, HQ-WEB01 |
| MONITORING | Observability | CORE + NS-ELK01, NS-EA01, NS-ZBX01, NS-GRAF01 |
| INCIDENT | Detection/RCA walkthrough | CORPORATE + MONITORING + synthetic clients |
| FULL-DEMO | Architecture demonstration | Start only the required scenario set |

## VM inventory

| VM | Role | OS | Network | vCPU | RAM |
|---|---|---|---|---:|---:|
| NS-FW01 | OPNsense firewall/router | OPNsense | WAN + all internal segments | 2 | 4 GB |
| HQ-DC01 | AD DS/DNS | Windows Server | SERVERS | 2 | 4 GB |
| HQ-DC02 | AD DS/DNS | Windows Server | SERVERS | 2 | 4 GB |
| HQ-MGMT01 | Jump/admin workstation | Windows Server | MGMT | 2 | 4 GB |
| HQ-FS01 | File services | Windows Server | SERVERS | 2 | 4 GB |
| HQ-PRN01 | Print services | Windows Server | SERVERS | 2 | 4 GB |
| HQ-SQL01 | SQL workload | Windows Server | SERVERS | 4 | 8 GB |
| HQ-APP01 | Internal application | Linux/Windows | SERVERS | 2 | 4 GB |
| HQ-WEB01 | DMZ web workload | Linux/Windows | DMZ | 2 | 4 GB |
| NS-ELK01 | Elastic stack | Linux | MONITORING | 4 | 8 GB |
| NS-EA01 | ElastAlert 2 | Linux | MONITORING | 2 | 2 GB |
| NS-ZBX01 | Zabbix | Linux | MONITORING | 2 | 4 GB |
| NS-GRAF01 | Grafana | Linux | MONITORING | 2 | 2 GB |
| HQ-CL01 | Synthetic corporate client | Windows | CORP-USERS | 2 | 4 GB |
| EAST-OT01 | OT telemetry simulator | Linux | OT | 2 | 2 GB |

## Hyper-V design principles

- Use Generation 2 guests where supported.
- Use dynamic memory only where it makes operational sense; pin minimums for infrastructure that needs predictable behaviour.
- Keep ISO/VHDX paths outside source control.
- Use checkpoints only as disposable lab recovery points, not as a substitute for backups.
- Provision NICs by network role and document each connection.

## Build order

1. Hyper-V switches
2. NS-FW01
3. HQ-DC01
4. HQ-DC02
5. HQ-MGMT01
6. Corporate servers
7. Monitoring stack
8. Clients and OT simulator
9. Scenario validation
