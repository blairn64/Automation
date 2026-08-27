# Naming Standards

The lab uses boring, consistent enterprise naming on purpose.

## Organisation

**Northstar Manufacturing Group**

Internal AD namespace: `northstar.internal`

The namespace is fictional and reserved for lab documentation only. Do not treat the examples as public DNS records.

## Site codes

| Code | Site |
|---|---|
| HQ | Head office / central services |
| EAST | East production site |
| WEST | West production site |

## Host format

`<SITE>-<ROLE><NUMBER>`

Examples:

- `HQ-DC01` — domain controller
- `HQ-FS01` — file server
- `HQ-PRN01` — print server
- `HQ-APP01` — application server
- `HQ-WEB01` — web server
- `HQ-SQL01` — SQL Server
- `HQ-MGMT01` — management/jump host
- `HQ-MON01` — Elastic/monitoring node
- `HQ-GRAF01` — Grafana node
- `HQ-ZBX01` — Zabbix node
- `HQ-FW01` — firewall/router

## Account conventions

- Standard users: `firstname.lastname`
- Privileged admins: `adm-firstname.lastname`
- Service accounts: `svc-<function>`

Examples:

- `jordan.lee`
- `adm-jordan.lee`
- `svc-monitoring`
- `svc-backup`

## AD structure

```text
northstar.internal
├── Corporate
│   ├── Users
│   ├── Workstations
│   └── Servers
├── Plant-East
│   ├── Users
│   ├── Workstations
│   └── OT
├── Plant-West
│   ├── Users
│   ├── Workstations
│   └── OT
├── Infrastructure
│   ├── Domain Controllers
│   ├── Management
│   └── Service Accounts
└── Privileged
    ├── Tier-0
    ├── Tier-1
    └── Tier-2
```

Names should describe ownership or function. Avoid cute lab names, random numbers and ambiguous abbreviations.
