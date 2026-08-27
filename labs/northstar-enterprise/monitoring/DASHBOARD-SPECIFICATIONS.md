# Northstar Enterprise Lab — Dashboard Specifications

These specifications are implementation-ready portfolio artefacts. They avoid pretending that uncollected data or screenshots already exist.

## 1. Operations Overview

**Purpose:** answer “what needs attention right now?”

Panels:
- active incidents by severity;
- host/service availability;
- DNS/identity health;
- application health;
- queue depth;
- telemetry freshness;
- capacity thresholds.

## 2. Identity and Access

Panels:
- authentication success/failure trend;
- top failing accounts (synthetic data);
- privileged change events;
- domain controller health;
- DNS error trend.

## 3. Platform Capacity

Panels:
- disk utilisation by server;
- growth trend;
- CPU saturation trend;
- memory pressure;
- stopped services;
- threshold breach timeline.

## 4. Telemetry Pipeline

Panels:
- producer event rate;
- RabbitMQ queue depth;
- consumer throughput;
- ingestion latency;
- Elasticsearch freshness;
- alert trigger count.

## 5. Application and Business Services

Panels:
- HTTP health;
- application errors;
- IIS/application pool state;
- database dependency checks;
- file service availability;
- print queue status.

## Implementation mapping

| Platform style | Artefact |
|---|---|
| Kibana | saved searches, Lens panels, alert rules |
| Grafana | dashboard JSON/panel definitions |
| Zabbix | host/service templates and triggers |
| ManageEngine | monitor/check catalogue and escalation mapping |

## Evidence rule
When the environment is running, add screenshots and exported dashboard definitions under a dated `evidence/` path. Do not add fabricated screenshots.
