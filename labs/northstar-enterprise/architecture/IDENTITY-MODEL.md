# Northstar Identity Model

## Domain design

The lab uses a synthetic enterprise domain and two domain controllers to demonstrate identity services without reproducing any real organisation.

## Administrative separation

Northstar models three practical identity contexts:

| Context | Purpose |
|---|---|
| Standard user | day-to-day applications and collaboration |
| Service identity | application/service execution with narrowly defined permissions |
| Administrative identity | privileged infrastructure administration |

Administrative activity should not be performed from ordinary user sessions when a dedicated administrative identity is available.

## OU model

```text
Northstar
├── Users
│   ├── HQ
│   ├── Plant-East
│   └── Plant-West
├── Workstations
│   ├── HQ
│   ├── Plant-East
│   └── Plant-West
├── Servers
│   ├── Core
│   ├── Infrastructure
│   ├── Applications
│   └── Monitoring
├── Groups
│   ├── Access
│   ├── Administration
│   └── Services
└── Service-Accounts
```

## Group design

Resource access should be assigned through role-oriented security groups rather than individual ACL assignments. The lab uses synthetic department groups for Finance, Operations, Engineering and IT to demonstrate delegated access patterns.

## Demonstrations supported

- Active Directory domain services
- DNS dependency troubleshooting
- user and group lifecycle automation
- role-based file access
- administrative separation
- Windows endpoint domain join
- identity-related incident investigation

The model intentionally demonstrates practices and architecture without containing any identities, addresses, policies or secrets from a previous workplace.
