# Northstar Enterprise Lab — Server and Service Catalogue

## Core inventory

| Host | Role | Primary services | Dependencies |
|---|---|---|---|
| DC01 | Primary identity | AD DS, DNS | Network, storage |
| DC02 | Secondary identity | AD DS, DNS | DC01/replication, network |
| FS01 | File services | SMB, department shares | AD, DNS, storage |
| PRN01 | Print services | Print Spooler, queues | AD, DNS, network |
| APP01 | Application | IIS, application pools | DNS, SQL/service dependencies |
| SQL01 | Database | SQL workload | AD/DNS as required, storage |
| MON01 | Monitoring | Elastic/Kibana integrations | Network, telemetry sources |
| MQ01 | Messaging | RabbitMQ | Network, producers/consumers |
| OPS01 | Operations tooling | scripts, checks, administration | Management access |

## Naming model

```text
<SITE>-<ROLE><NUMBER>
```

Examples:
- HQ-DC01
- HQ-FS01
- HQ-APP01
- PL1-OT01
- MGMT-MON01

The actual VM names may be shortened for local Hyper-V practicality, but documentation should preserve the enterprise role.

## Service ownership model

| Service area | Synthetic owner |
|---|---|
| Identity | Identity & Access team |
| Network | Network Operations |
| Servers | Infrastructure Operations |
| Applications | Application Support |
| Telemetry | OT/Platform Engineering |
| Monitoring | NOC / Operations |

## Minimum health signals
- DCs: replication and DNS response
- File server: share reachability and capacity
- Print server: spooler and queue state
- Application server: HTTP/application health
- Database: service state and synthetic query
- RabbitMQ: connectivity and queue depth
- Elastic: ingestion freshness
- Alerting: rule execution and expected trigger path
