# Enterprise Operations Runbook

## Scope

This runbook describes the synthetic 5,000-user / multi-site manufacturing lab in operational terms.

## Normal data flow

1. Synthetic users generate identity events.
2. Factory simulators emit telemetry events.
3. Application services validate and persist operational records.
4. RabbitMQ/AMQP decouples telemetry producers from processing consumers.
5. Monitoring components consume health and alert signals.
6. KPI/reporting datasets are generated for operational review.

## Incident: user authentication failures

Check the synthetic sign-in dataset for failure spikes by site, client and country. Then inspect the identity-policy simulation and determine whether the problem is localised or estate-wide. The lab is designed to exercise diagnosis, not to perform real tenant changes.

## Incident: factory application unreachable

Check network reachability first, then application process health, then dependent SQL connectivity. Confirm whether telemetry ingestion is still active. Separate the user-facing application fault from the underlying telemetry source.

## Incident: stale production data

Compare source telemetry timestamps with application records and queue timestamps. A healthy source with stale SQL data should focus investigation on the application worker, queue consumer or database layer rather than the PLC/sensor simulator.

## Incident: RabbitMQ backlog

Inspect queue depth, consumer availability and message age. Confirm whether the downstream processor is failing or intentionally paused. Recovery should preserve message acknowledgement semantics and avoid duplicate destructive processing.

## Incident: monitoring noise

Review alert frequency against a known synthetic baseline. Group related events, lower severity for expected transient conditions and escalate only when service impact is meaningful.

## Evidence produced

- `users.csv` — 5,000 synthetic user population.
- `signins.csv` — synthetic authentication telemetry.
- `support-tickets.csv` — synthetic service-desk workload.
- `factory-lab/` — telemetry producer, queue consumer and tests.

## Safety

Nothing in this lab should require access to a real tenant, production network, customer record or industrial control system. All external integrations are represented by synthetic data, mock boundaries or explicitly isolated lab components.
