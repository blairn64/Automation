# Northstar Enterprise Lab — Identity and OU Operating Model

## Directory structure

```text
NORTHSTAR.LOCAL
├── Tier-0
│   ├── Domain Admins
│   └── Identity Services
├── Servers
│   ├── Domain Controllers
│   ├── Infrastructure
│   └── Applications
├── Workstations
│   ├── HQ
│   ├── Plant-01
│   └── Plant-02
├── Users
│   ├── IT Operations
│   ├── Engineering
│   ├── Finance
│   ├── Operations
│   └── Service Desk
├── Service Accounts
└── Groups
    ├── Security
    └── Distribution
```

## Account model

### Standard user
Used for ordinary workstation and business-service access.

### Administrative identity
Separate from standard user accounts. Administrative permissions should be assigned deliberately and scoped to the management task.

### Service identity
Used by synthetic services and workloads. These accounts should not be treated as ordinary interactive user accounts.

## Group-driven access
The lab models access through groups rather than individual permissions where practical.

Example:

```text
GG-FIN-File-Modify
      ↓
Department Finance Users
      ↓
FS01 Finance Share
```

## Operational checks
- confirm expected account is enabled;
- confirm group membership;
- confirm DNS and DC reachability;
- confirm time synchronisation;
- inspect relevant authentication events;
- validate resource access from a standard user perspective.

## Security principle
Northstar demonstrates administrative separation and least-privilege concepts without copying any real employer directory, naming convention, user data or access model.
