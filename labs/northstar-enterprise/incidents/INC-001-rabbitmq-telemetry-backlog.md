# INC-001 — Plant telemetry backlog

## Summary

A simulated OT telemetry producer continues publishing while downstream consumers stop processing messages. Queue depth rises, production-style telemetry becomes delayed, and an operational alert is generated.

## Story

```mermaid
sequenceDiagram
    participant OT as OT Simulator
    participant MQ as RabbitMQ
    participant ES as Elastic
    participant EA as ElastAlert 2
    participant SD as Service Desk
    participant ENG as Infrastructure Engineer

    OT->>MQ: Publish telemetry
    Note over MQ: Consumer degraded
    MQ-->>ES: Queue depth events rise
    ES->>EA: Matching monitoring data
    EA->>SD: Create synthetic incident
    SD->>ENG: Assign P2
    ENG->>MQ: Check queue and consumers
    ENG->>MQ: Restore consumer
    MQ-->>ES: Queue depth normalises
    ENG->>SD: Recovery evidence + RCA
```

## Detection

The included rule watches synthetic queue-depth events and requires repeated threshold breaches to reduce noise.

## Investigation checklist

1. Confirm the alert window and affected queue.
2. Check whether producers are still publishing.
3. Check consumer count and consumer errors.
4. Check broker resource state.
5. Confirm downstream ingestion health.
6. Restore the failed/degraded component.
7. Confirm queue depth returns to baseline.
8. Record cause, recovery and prevention action.

## Root-cause variants

Use one variant at a time:

- consumer process stopped
- consumer authentication failure
- downstream endpoint unavailable
- broker resource pressure

## Success criteria

The scenario is complete only when the repository can show:

- synthetic event source
- queue backlog
- detection rule match
- incident record
- investigation notes
- recovery evidence
- post-incident action
