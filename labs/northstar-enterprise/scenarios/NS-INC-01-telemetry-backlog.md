# NS-INC-01 — OT Telemetry Backlog

## Objective

Demonstrate detection and investigation of a synthetic telemetry pipeline backlog affecting operational data delivery.

## Normal state

`OTSIM01` generates structured synthetic production telemetry. Messages are published to RabbitMQ, consumed by the Northstar telemetry service, and indexed for analysis. Normal operation is characterised by steady queue depth and current event timestamps.

## Controlled fault

Use the Northstar scenario tooling to pause or constrain the synthetic consumer path so that messages accumulate in the lab queue. Do not alter production or external services.

## Expected symptoms

- Queue depth rises above the baseline.
- New events arrive late relative to their source timestamp.
- Downstream dashboards show a widening ingestion delay.
- Recovery causes queue depth to fall and freshness to return.

## Detection

Primary signals:

- queue depth above threshold;
- event freshness exceeding the scenario threshold;
- ElastAlert2 notification generated from the synthetic monitoring data.

## Investigation sequence

1. Confirm publisher activity.
2. Check RabbitMQ queue depth and consumer count.
3. Confirm consumer process/container health.
4. Compare source event time with ingest time.
5. Inspect consumer errors and dependency health.
6. Restore the consumer path.

## Recovery validation

Recovery is complete only when:

- queue depth returns toward baseline;
- consumer throughput is restored;
- newly generated events are current;
- no continuing alert condition remains.

## Evidence to retain

- scenario parameters;
- queue-depth samples;
- representative event timestamps;
- consumer logs;
- alert record;
- recovery timestamp;
- evidence manifest.

## RCA template

**Impact:**

**Detection:**

**Technical cause:**

**Contributing factors:**

**Recovery action:**

**Prevention / follow-up:**
