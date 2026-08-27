# Northstar Active Directory

## Forest

`northstar.internal`

The lab deliberately uses a fictional namespace and synthetic identities.

## Domain controller design

- `HQ-DC01` — primary lab DC/DNS
- `HQ-DC02` — secondary DC/DNS

Both domain controllers provide an opportunity to demonstrate DNS troubleshooting, replication checks, authentication dependencies and failure scenarios.

## OU model

```text
northstar.internal
├── Privileged
│   ├── Tier-0
│   ├── Tier-1
│   └── Tier-2
├── Infrastructure
│   ├── Domain Controllers
│   ├── Servers
│   └── Service Accounts
├── HQ
│   ├── Users
│   ├── Workstations
│   └── Groups
├── Plant-East
│   ├── Users
│   ├── Workstations
│   └── OT
└── Plant-West
    ├── Users
    ├── Workstations
    └── OT
```

## Administration model

Administrative work is performed from `HQ-MGMT01` rather than ordinary user endpoints. Privileged accounts are separate synthetic identities, for example `adm.alex.morgan`, while service identities use role-based names such as `svc.monitoring`.

## Demonstrations

The lab can support:

- user lifecycle automation
- group-based access control
- DNS dependency troubleshooting
- domain controller replication health checks
- privileged account separation
- service account auditing
- synthetic authentication incidents

See the existing `active-directory/` automation collection for reusable lab scripts.
