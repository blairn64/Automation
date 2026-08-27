# Factory Telemetry Lab — Architecture

## Purpose

The lab models a simple production telemetry path without connecting to real industrial equipment.

## Data flow

```text
Synthetic sensor process
        |
        | JSON / AMQP
        v
   RabbitMQ queue
        |
        v
  Processing worker
     /       \
 validation   anomaly rules
        \       /
         v     v
        structured result
```

## Boundaries

**Edge simulation** generates timestamped readings and production state.

**Messaging** decouples producers from consumers and allows work to be buffered during downstream interruptions.

**Processing** validates the event contract before applying simple operational thresholds.

**Output** is deliberately lightweight so the same event model could later feed SQL, Elasticsearch or another reporting service.

## Event contract

Required fields:

- `timestamp`
- `site`
- `line`
- `machine`
- `temperature_c`
- `load_pct`
- `units_per_minute`
- `state`

## Why this design

The point is to demonstrate integration and operational thinking rather than implement a proprietary industrial protocol. Keeping the plant-side source synthetic also makes the project safe to publish and easy for another engineer to run locally.
