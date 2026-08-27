# Lab Architecture and Responsibilities

## 1. Factory subnet

Represents a production VLAN/subnet containing application and machine-facing services. In a real environment this is a controlled network segment; in this lab it is represented by isolated containers and named service roles.

## 2. Application tier

An IIS-style application service exposes operational endpoints and receives or serves production data. The implementation can be hosted on Flask/Linux for portability while retaining the same separation of concerns: web tier -> data tier -> telemetry services.

## 3. SQL tier

Stores work orders, production events and latest machine state. Access is application-mediated rather than allowing arbitrary clients to modify production records.

## 4. SAP integration boundary

The lab models SAP as an upstream/downstream business-system boundary. The adapter converts a small, synthetic production event into a business-facing message. It does not emulate SAP internally.

## 5. PLC / machine layer

A disposable PLC simulator exposes a tag model representing machine state, count, temperature and weight. Siemens S7 is treated as an integration boundary; no real PLC should ever be targeted by the lab unless explicitly authorised.

## 6. Telemetry layer

Sensors and industrial scales are represented by synthetic event generators. Each event has an asset identifier, timestamp, metric, value and health/status information.

## 7. Message bus

RabbitMQ/AMQP separates event production from downstream processing. This lets the consumer fail or restart without losing the architectural distinction between acquisition and processing.

## 8. Monitoring / SIEM

Processed events can be emitted as structured JSON for ingestion into Elasticsearch or other observability tools. Dashboards can consume the synthetic KPI dataset separately.

## Troubleshooting model

The expected troubleshooting order is:

1. Is the host/service reachable?
2. Is the network boundary allowing the required path?
3. Is the application process healthy?
4. Is the application receiving data?
5. Is the queue accepting and delivering messages?
6. Is the database being updated?
7. Is the downstream business/monitoring integration processing the event?

This deliberately mirrors layered production troubleshooting rather than treating every incident as an application bug.

## Siemens context

For a lab that needs genuine S7 protocol interaction, current `python-snap7` documentation supports Siemens S7 communication and includes a server/testing capability. Modern S7-1200/1500 communication can involve S7CommPlus; older PUT/GET examples are treated as separate compatibility paths. citeturn491738search0turn491738search2
