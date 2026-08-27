# Factory network segmentation

Synthetic network policy for a multi-site manufacturing environment.

| Source zone | Destination zone | Service | Decision | Reason |
|---|---|---|---|---|
| User | Identity | HTTPS | Allow | Authentication |
| User | App | HTTPS | Allow | Business application access |
| App | SQL | TCP/1433 | Allow | Database dependency |
| App | ERP boundary | HTTPS | Allow | Order/status integration |
| OT | App | AMQP | Allow | Telemetry ingestion |
| OT | Internet | Any | Deny | Reduce exposure |
| Guest | Production | Any | Deny | Isolation |
| Monitoring | Hosts | ICMP/agent ports | Allow | Health collection |

This file is a design artifact only. It contains no production addresses or firewall identifiers.

## Troubleshooting use

Start with the application dependency map, validate name resolution, validate route/path, test the required TCP port, then compare the observed path with the intended policy. Avoid broad temporary rules as a first response.
