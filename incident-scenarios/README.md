# Incident response scenarios

Short, reproducible troubleshooting exercises based on common enterprise support failures.

## 001 — Factory telemetry outage

User report: production telemetry is missing.

Investigation path:

1. Confirm affected site/asset scope.
2. Check application reachability.
3. Check queue depth and consumer health.
4. Validate recent telemetry timestamps.
5. Compare source event with processed event.
6. Identify the failed dependency.
7. Restore the failed service through the approved change process.
8. Confirm queue drain and data recovery.

## 002 — IIS 503

Check DNS, TCP path, HTTP response, IIS logs, application-pool state and backend dependencies before making changes.

## 003 — SQL latency

Check application timeout, connection reachability, active requests, blocking and resource pressure. Avoid terminating sessions as a first response.

## 004 — Identity failure spike

Compare affected users, clients, locations and timestamps. Check authentication telemetry and policy changes before changing controls.

## 005 — Network segmentation fault

Validate intended source/destination/service flow, DNS, route and TCP connectivity against the approved firewall policy.

## 006 — Elastic ingestion gap

Trace the event from source to shipper to pipeline to index, then confirm parsing and timestamp fields.

## Incident record template

- Impact:
- Detection time:
- Scope:
- Evidence collected:
- Suspected cause:
- Confirmed cause:
- Recovery action:
- Validation:
- Follow-up:
