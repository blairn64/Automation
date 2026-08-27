# Northstar Infrastructure Build

This directory contains deployment building blocks for the synthetic Northstar Manufacturing Group environment.

## Build order

```mermaid
flowchart TD
  N[Hyper-V switches] --> F[OPNsense routing and segmentation]
  F --> D1[HQ-DC01 forest and DNS]
  D1 --> D2[HQ-DC02 replica]
  D2 --> AD[Directory baseline]
  AD --> DHCP[DHCP scopes]
  AD --> FS[File services]
  AD --> PRN[Print services]
  AD --> IIS[IIS application]
  IIS --> SQL[Application data workload]
  FS --> MON[Monitoring and Elastic]
  MON --> EA[ElastAlert 2]
  EA --> INC[Incident scenarios]
```

## Scripts

| Script | Target | Purpose |
|---|---|---|
| `Initialize-NorthstarDhcp.ps1` | DHCP server | Creates synthetic user/device scopes |
| `Install-NorthstarIISApp.ps1` | HQ-APP01 | Installs IIS and a synthetic operations portal |

## Operational rule

These scripts are **lab automation**, not production deployment templates. Review network addresses, credentials, certificates and firewall policy before running anything.

## Next components

- SQL workload bootstrap
- print queues and GPO deployment
- file-server NTFS ACL baseline
- Windows client join and policy simulation
- telemetry agents and incident injection controls
