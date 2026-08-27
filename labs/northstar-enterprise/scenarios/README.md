# Northstar Incident Catalogue

Northstar is designed to be operated as an enterprise-style environment, not merely deployed. Each scenario starts from a documented normal state, introduces a controlled synthetic fault, produces observable telemetry, and ends with recovery validation and a concise root-cause analysis.

## Scenario set

| ID | Scenario | Primary systems | Core evidence |
|---|---|---|---|
| NS-INC-01 | OT telemetry backlog | RabbitMQ, telemetry consumer, Elasticsearch | queue depth, delayed events, recovery timeline |
| NS-INC-02 | Identity and DNS failure | AD DS, DNS, Windows clients | lookup failures, authentication symptoms, service state |
| NS-INC-03 | Print service outage | PRN01, Windows clients | spooler state, queue symptoms, recovery evidence |
| NS-INC-04 | Web application degradation | APP01/IIS, application logs | HTTP failures, IIS/application logs, health checks |
| NS-INC-05 | Infrastructure capacity alert | monitored servers, Elastic/Grafana-style telemetry | resource threshold, alert, remediation validation |

## Standard scenario lifecycle

1. Confirm baseline health.
2. Capture the intended normal-state evidence.
3. Introduce the synthetic fault only inside the lab boundary.
4. Confirm expected telemetry is generated.
5. Detect and triage using the documented signals.
6. Investigate using evidence rather than assumptions.
7. Recover the affected service.
8. Validate normal operation.
9. Preserve an evidence manifest and RCA.

No scenario is intended to target external systems, production infrastructure, or real organisations. All identities, hosts, domains, addresses and events are synthetic.
