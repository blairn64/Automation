# Elastic operational telemetry lab

Synthetic events for demonstrating ingestion, field normalisation, threshold detection and operational dashboards.

The sample events are intentionally small and generic. A production implementation would typically add an ingest pipeline, index template, retention policy and alerting rules appropriate to the environment.

## Suggested detections

- Critical telemetry threshold
- Application response-time degradation
- Missing telemetry from an expected asset
- Repeated authentication failures
- Queue backlog growth

## Troubleshooting path

Source -> collector/shipper -> pipeline -> index -> query -> alert -> ticket.
