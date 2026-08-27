# Northstar Enterprise Lab — Monitoring and Alert Catalogue

## Monitoring philosophy
Alerts should represent conditions that require attention. Dashboards provide context; alerts create a prioritised signal.

## Identity and infrastructure

| Signal | Severity | Investigation |
|---|---|---|
| AD replication failure | High | replication, DNS, connectivity |
| DNS resolution failure trend | High | DNS service, network, records |
| Authentication failure spike | Medium | source, account, scope |
| Privileged group change | High | validate change and actor |

## Platform

| Signal | Severity | Investigation |
|---|---|---|
| Disk capacity threshold | Medium/High | growth, largest consumers, service impact |
| Service stopped | High | dependency and event logs |
| CPU saturation trend | Medium | process, workload, capacity |
| Memory pressure | Medium | process, service, leak pattern |

## Application

| Signal | Severity | Investigation |
|---|---|---|
| HTTP health failure | High | IIS, DNS, app pool, dependency |
| Error-rate increase | High | application logs, change history |
| Database query failure | High | SQL service, connectivity, workload |

## Messaging and telemetry

| Signal | Severity | Investigation |
|---|---|---|
| Queue depth growth | Medium/High | consumer, producer rate, connectivity |
| Consumer unavailable | High | process, host, credentials, queue |
| Ingestion freshness stale | High | beat/consumer/indexing path |
| Alert rule trigger | Contextual | validate event and business impact |

## Alert lifecycle

```text
Signal → Threshold/Rule → Alert → Triage → Investigation
      → Recovery → Validation → Tune/Close
```

## Dashboard model
A production-style view should prioritise:
- service availability;
- current incidents;
- queue depth;
- ingestion freshness;
- capacity trends;
- authentication/DNS health;
- application health.

The dashboard should answer “what needs attention?” before exposing every raw metric.
