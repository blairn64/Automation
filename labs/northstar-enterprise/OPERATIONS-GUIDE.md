# Northstar Enterprise Lab — Operations Guide

## Purpose
This guide describes how to operate the synthetic Northstar enterprise environment after deployment. Northstar is a portfolio lab: all organisations, hosts, users, addresses, telemetry and incidents are synthetic.

## Operating model

```text
Users / Clients
      |
Identity + DNS ---- Core Services ---- Business Apps
      |                  |                 |
      +------------------+-----------------+
                         |
                    Monitoring
                         |
             Detect -> Investigate -> Recover
```

## Daily checks

### Identity
- Confirm DC01 and DC02 are reachable.
- Check AD replication.
- Confirm DNS resolves core hosts.
- Review privileged/admin account activity.
- Check failed authentication trends.

### Core infrastructure
- Confirm file shares are reachable.
- Check print queues for stalled jobs.
- Check IIS/application health.
- Check SQL service availability and synthetic query health.
- Confirm scheduled backup/maintenance jobs report normally.

### Monitoring
- Confirm Elastic ingestion is current.
- Confirm RabbitMQ queues are not accumulating unexpectedly.
- Confirm alert rules are enabled.
- Check dashboard freshness.

## Standard incident workflow
1. Record time and scope.
2. Confirm whether the issue is isolated or systemic.
3. Preserve logs and current evidence before making changes.
4. Check service dependencies from `architecture/SERVICE-DEPENDENCY-MAP.md`.
5. Identify the smallest safe recovery action.
6. Validate the service from the user perspective.
7. Capture recovery evidence.
8. Record root cause and preventative actions.

## Safe change model
Northstar changes are treated as production-style changes:
- document purpose and rollback;
- identify dependencies;
- prefer reversible changes;
- validate before and after;
- capture evidence;
- update documentation when the architecture changes.

## Operational commands and scripts
Use the repository deployment and validation scripts as the source of truth. Do not treat screenshots as configuration authority.

## Escalation examples
- **Identity:** replication, DNS, authentication or privileged access failures.
- **Network:** routing, VLAN, firewall or name-resolution path failures.
- **Application:** IIS, service, database or dependency failures.
- **Telemetry:** producer, queue, consumer, indexing or alerting failures.

## Related documents
- `BUILD-ORDER.md`
- `architecture/NETWORK-SECURITY-MODEL.md`
- `architecture/IDENTITY-MODEL.md`
- `architecture/FIREWALL-POLICY-MATRIX.md`
- `scenarios/README.md`
