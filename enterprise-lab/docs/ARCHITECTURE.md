# Enterprise Lab Architecture

## Purpose

Reproduce the technical shape of a large, multi-site manufacturing support environment without reproducing any real employer implementation.

## Layers

| Layer | Synthetic representation | Engineering concern |
| --- | --- | --- |
| Users | 5,000 generated users | Identity scale, reporting, support demand |
| Identity | Entra/M365-style events | Authentication, access, policy analysis |
| Network | IT, factory and OT-style zones | Segmentation and controlled connectivity |
| Application | IIS-style service | Application availability and dependencies |
| Data | SQL-backed production records | Staleness, consistency, query paths |
| Business integration | SAP-style boundary | External system dependency isolation |
| OT | PLC/machine and sensor simulators | Telemetry generation and source-of-truth tracing |
| Messaging | RabbitMQ/AMQP | Decoupling, retries, backlog handling |
| Observability | Elastic + dashboard-oriented outputs | Detection, alerting, triage |
| Operations | Synthetic service desk data | Incident volume, escalation and root cause |

## Key engineering boundary

The OT layer never depends on an internet-facing service. Telemetry crosses into the IT data pipeline through a defined ingestion boundary. The lab models the boundary and the diagnostic path without connecting to real industrial equipment.

## Failure-domain thinking

An incident is classified by the earliest reliable point of failure:

- source device / telemetry generation
- network path
- application service
- message transport
- processing worker
- database
- reporting / observability

This prevents troubleshooting from jumping straight to the most visible symptom.
