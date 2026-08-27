# Northstar Enterprise Lab — Synthetic Enterprise Workload Model

## Purpose
Northstar is not a collection of idle virtual machines. This model gives each platform a believable operational role and creates controlled activity for monitoring, troubleshooting and incident scenarios.

All organisations, users, data and events are synthetic.

## Synthetic organisation

**Northstar Manufacturing Group (NMG)** is a fictional multi-site organisation with central IT and operational technology workloads.

### Sites
- HQ — corporate services and central infrastructure
- Plant-01 — production telemetry and operational workloads
- Plant-02 — secondary operational site model
- DR/Management — administrative and monitoring services

## Departments

| Department | Example workload |
|---|---|
| IT Operations | Identity, infrastructure, monitoring |
| Engineering | Application and telemetry access |
| Finance | File shares and line-of-business access |
| Operations | Production dashboards and shared resources |
| HR | Controlled file access and standard productivity services |
| Service Desk | User support and incident triage |

## Daily synthetic activity

### Users
- domain logons during business hours;
- DNS lookups for internal services;
- access to department shares;
- print submissions;
- application requests;
- occasional password and access failures.

### Servers
- AD authentication and replication;
- DNS requests;
- IIS health requests;
- database query checks;
- file-share access;
- print queue processing;
- scheduled maintenance activity.

### Telemetry
- synthetic device/line events;
- production counters;
- queue messages;
- consumer processing;
- indexed events;
- threshold-based alerts.

## Workload rhythm

```text
08:00  Users sign in / infrastructure baseline
09:00  Business applications become active
10:00  File, print and database workload increases
12:00  Reduced user activity / background services continue
14:00  Operational telemetry peak
16:00  Reporting and file activity
18:00  Maintenance and monitoring checks
```

## Controlled fault injection
Faults are deliberate, reversible and documented. They are introduced only through the incident scenarios and should produce observable symptoms.

Examples:
- pause telemetry consumer;
- introduce controlled DNS dependency failure;
- stop or stall print processing;
- disable an IIS application component;
- create synthetic disk/capacity pressure.

## Design rule
Every workload should answer three questions:
1. What business or operational function does it represent?
2. What telemetry should prove it is healthy?
3. Which dependency failure can demonstrate troubleshooting skill?
