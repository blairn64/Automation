# Industrial IT/OT Production Lab

A synthetic, reproducible model of a **large multi-site manufacturing support environment**.

The lab demonstrates the *types of systems, boundaries, troubleshooting paths and integrations* involved in production IT/OT support, including an enterprise identity layer serving thousands of users.

## Environment model

```text
                         Enterprise / IT
                              |
                 +------------+-------------+
                 | 5,000-user identity lab  |
                 | M365 / Entra-style data  |
                 +------------+-------------+
                              |
                  Firewall / segmentation
                              |
                 +------------v-------------+
                 |       Factory Zone       |
                 |                          |
                 | IIS-style App Tier       |
                 |        |                 |
                 |      SQL data             |
                 |        |                 |
                 | Production services      |
                 +------------+-------------+
                              |
                   Controlled OT boundary
                              |
              +---------------+----------------+
              |                                |
        PLC / machine simulator          Sensor / scale data
              |                                |
              +-------------> telemetry -------+
                                   |
                              RabbitMQ/AMQP
                                   |
                          Processing / alerting
                                   |
                         Elastic / dashboards
```

## Scale model

`enterprise_scale.py` generates a configurable synthetic estate with a default of **5,000 users across multiple sites**, including department, role, MFA-registration and cloud-enabled status. `support-volume.py` generates synthetic service-desk demand suitable for demonstrating administration and automation at enterprise scale.

These scripts create local CSV data only. They do **not** create accounts, contact Microsoft 365/Entra, or interact with a real service desk.

## What is being demonstrated

- Multi-site factory networks and segmented production zones.
- Identity and administration at thousands-of-users scale.
- Application support for an IIS-style production service.
- SQL-backed production data.
- Synthetic SAP-style business integration boundary.
- PLC and sensor/scale telemetry as structured events.
- Queue-based decoupling with RabbitMQ/AMQP.
- Monitoring, logging and alert generation.
- Troubleshooting across application, database, network and telemetry layers.
- Operational reporting and support-demand analysis.

## Interview scenarios

1. Thousands of users experience an identity or access issue while production continues.
2. A factory application remains reachable but stops receiving telemetry.
3. SQL data becomes stale while the application remains healthy.
4. Queue backlog grows because a downstream processor is unavailable.
5. Sensor values cross an operational threshold and generate an alert.
6. A segmented network path blocks the expected application-to-service connection.
7. Support demand spikes across identity, M365, network and factory-telemetry categories and automation is used to triage the workload.

## Important distinction

The lab uses **simulators** for production roles. It is not a copy of any employer network and contains no production credentials, hostnames, addresses, customer information or proprietary configurations.

The PLC layer is represented as a protocol/data-flow boundary. Where Siemens S7 communication is demonstrated, use a disposable simulator or test PLC only. `python-snap7` provides Siemens S7 communication and a server/testing capability for isolated lab work.

## Technologies

Python • Flask • SQL • RabbitMQ/AMQP • Docker • PowerShell • Linux • Elasticsearch • Kibana • Grafana/Zabbix-style monitoring • REST APIs • Siemens S7 lab concepts
