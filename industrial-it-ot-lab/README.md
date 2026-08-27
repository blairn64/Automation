# Industrial IT/OT Production Lab

A synthetic, reproducible model of a multi-site manufacturing support environment.

This lab demonstrates the *types of systems, boundaries, troubleshooting paths and integrations* involved in production IT/OT support without reproducing any employer-specific configuration, identifiers or data.

## Environment model

```text
                         Enterprise / IT
                              |
                 +------------+------------+
                 | Identity / Admin / SIEM |
                 +------------+------------+
                              |
                    Firewall / segmentation
                              |
                 +------------v------------+
                 |       Factory Zone      |
                 |                         |
                 |  IIS-style App Tier     |
                 |        |                |
                 |     SQL data            |
                 |        |                |
                 |  Production services    |
                 +------------+------------+
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

## What is being demonstrated

- Segmented factory subnets and an OT boundary.
- Application support for an IIS-style production service.
- SQL-backed production data.
- Synthetic SAP-style business integration boundary.
- PLC and sensor/scale telemetry as structured events.
- Queue-based decoupling with RabbitMQ/AMQP.
- Monitoring, logging and alert generation.
- Troubleshooting across application, database, network and telemetry layers.
- Read-only diagnostics and safe failure simulation.

## Important distinction

The lab uses **simulators** for production roles. It is not a copy of any employer network and contains no production credentials, hostnames, addresses, customer information or proprietary configurations.

The PLC layer is represented as a protocol/data-flow boundary. Where Siemens S7 communication is demonstrated, use a disposable simulator or test PLC only. `python-snap7` supports native Siemens S7 communication and provides a server/testing capability, making it suitable for an isolated lab. citeturn491738search0turn491738search3

## Interview scenarios

1. Factory application stops receiving telemetry.
2. SQL data is stale while the application remains reachable.
3. Queue backlog grows because a downstream processor is unavailable.
4. Sensor values cross an operational threshold and generate an alert.
5. A segmented network path blocks the expected application-to-service connection.
6. Production metrics differ from the source telemetry and require tracing through the pipeline.

## Technologies

Python • Flask • SQL • RabbitMQ/AMQP • Docker • PowerShell • Linux • Elasticsearch • Kibana • Grafana/Zabbix-style monitoring • REST APIs • Siemens S7 lab concepts
