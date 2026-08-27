# Northstar Enterprise Lab — Enterprise Architecture

## Synthetic organisation model
Northstar represents a medium-sized multi-site enterprise with central infrastructure, segmented user/server workloads and a small production-style telemetry environment.

```mermaid
flowchart TB
    INTERNET[Internet / External]
    FW[OPNsense Firewall]
    INTERNET --> FW

    FW --> MGMT[Management VLAN]
    FW --> SRV[Server VLAN]
    FW --> USR[Corporate User VLAN]
    FW --> OT[Telemetry / OT VLAN]
    FW --> MON[Monitoring VLAN]

    SRV --> DC1[DC01]
    SRV --> DC2[DC02]
    SRV --> FS[FS01]
    SRV --> PRN[PRN01]
    SRV --> APP[APP01 / IIS]
    SRV --> SQL[SQL01]

    USR --> CLIENTS[Domain Clients]
    OT --> PROD[Synthetic Producers]
    PROD --> MQ[RabbitMQ]
    MQ --> CONSUMER[Telemetry Consumer]
    CONSUMER --> ES[Elasticsearch]
    MON --> ES
    ES --> KIBANA[Kibana]
    ES --> ALERT[ElastAlert 2]
```

## Core layers

### Edge and segmentation
OPNsense provides the lab's routed boundaries and policy enforcement. Segments are designed around management, infrastructure, users, telemetry and monitoring responsibilities.

### Identity
Two domain controllers model resilient AD/DNS services. The identity model separates ordinary users, service identities and privileged administration.

### Business services
File, print, application and database services provide realistic operational dependencies for incidents and troubleshooting.

### Monitoring and telemetry
The monitoring layer is independent enough to demonstrate detection and investigation when individual business services fail.

## Design principles
- synthetic data only;
- explicit segmentation;
- dependency-aware troubleshooting;
- observable workloads;
- reproducible incident scenarios;
- automation where it improves consistency;
- documentation treated as part of the system.

## What this demonstrates
- Hyper-V lab design;
- enterprise identity concepts;
- DNS and service dependencies;
- network segmentation;
- Windows/Linux operations;
- PowerShell/Python automation;
- RabbitMQ messaging;
- Elastic observability;
- alerting and incident response;
- root-cause-driven troubleshooting.
