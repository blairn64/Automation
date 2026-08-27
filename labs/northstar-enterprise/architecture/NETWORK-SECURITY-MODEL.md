# Northstar Network and Security Model

## Design intent

Northstar models a believable mid-sized enterprise with corporate and operational workloads separated by purpose. The design favours explicit trust boundaries, controlled management access and observable traffic over a flat lab network.

## Logical zones

| Zone | Purpose | Example systems |
|---|---|---|
| MGMT | administration and infrastructure management | admin workstation, Hyper-V management |
| SERVER | shared enterprise services | DC01, DC02, FS01, PRN01, APP01, SQL01 |
| USER-HQ | headquarters client fleet | finance, operations, engineering clients |
| PLANT-EAST | synthetic production-site clients | operator and engineering endpoints |
| PLANT-WEST | second production-site clients | operator and engineering endpoints |
| MONITORING | observability platform | Elastic, Kibana, RabbitMQ, alerting |
| LAB-TRANSIT | controlled routing and firewall boundary | OPNsense interfaces |

## Naming model

Hosts use functional names rather than personal or historical workplace naming:

- `DC01`, `DC02`
- `FS01`
- `PRN01`
- `APP01`
- `SQL01`
- `MON01`
- `OTSIM01`
- `CL-HQ-###`
- `CL-PE-###`
- `CL-PW-###`

## Policy principles

1. Management access originates from the management zone.
2. Clients do not receive unrestricted server-to-server access.
3. Monitoring is allowed to receive telemetry through documented ingestion paths.
4. Cross-zone traffic must have an explicit service requirement.
5. Administrative identities are separated from standard user activity.
6. Synthetic OT workloads are isolated from the corporate client networks except for defined monitoring and management paths.

## Example trust flow

```text
Management → Infrastructure
Users → Published corporate services
Servers → Required backend dependencies
Endpoints → DNS / identity services
Telemetry sources → RabbitMQ / Beats → Monitoring
Monitoring → Alerting / investigation
```

This document describes the target architecture. Concrete IP ranges and interface names are deliberately maintained in the deployment configuration so the model can be adapted without rewriting the architecture.
