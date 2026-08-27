# Northstar Enterprise Lab — Troubleshooting Guide

## Use this order

```text
Symptom
  ↓
Scope
  ↓
Network reachability
  ↓
DNS
  ↓
Identity
  ↓
Service
  ↓
Dependency
  ↓
Logs / telemetry
  ↓
Recovery + validation
```

## DNS or authentication failure

**Symptoms**
- users cannot sign in;
- domain resources fail intermittently;
- hosts cannot resolve internal names.

**Checks**
1. Test network reachability to domain controllers.
2. Query DNS directly.
3. Confirm time synchronisation.
4. Check AD replication.
5. Review authentication and DNS event logs.

**Do not** immediately restart domain controllers without identifying whether the failure is network, DNS, replication or service related.

## File share failure

Check:
- server reachability;
- DNS resolution;
- SMB service state;
- share availability;
- NTFS/share permissions;
- storage capacity.

## Print outage

Check:
- print server reachability;
- spooler state;
- queue state;
- driver health;
- client connectivity;
- printer/network reachability.

Use `NS-INC-03-print-outage.md` for the controlled scenario.

## IIS/application outage

Check:
- DNS;
- TCP reachability;
- IIS site/application pool state;
- application logs;
- downstream database/service dependencies;
- recent configuration changes.

Use `NS-INC-04-iis-application-outage.md` for the controlled scenario.

## Telemetry backlog

Check:
- producer activity;
- RabbitMQ connection state;
- queue depth;
- consumer availability;
- Elasticsearch connectivity;
- index/write failures;
- alerting rule assumptions.

Use `NS-INC-01-telemetry-backlog.md` for the controlled scenario.

## Capacity alert

Check:
- CPU/memory/disk trend rather than only current value;
- largest processes or files;
- service impact;
- capacity threshold;
- whether cleanup is safe;
- whether the alert requires tuning.

Use `NS-INC-05-capacity-alert.md` for the controlled scenario.

## Evidence standard
For every non-trivial incident capture:
- timestamps;
- affected services;
- commands/checks performed;
- relevant log excerpts;
- before/after state;
- recovery action;
- validation result;
- root cause or current hypothesis.
