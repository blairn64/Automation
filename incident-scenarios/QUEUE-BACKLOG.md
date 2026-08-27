# RabbitMQ Queue Backlog

**Symptoms:** Queue depth rises while producers remain healthy.

**Evidence:** Compare publish/consume rates, consumer availability and recent deployment changes.

**Isolation:** Confirm whether the consumer is stopped, erroring or slower than production.

**Recovery:** Restore the approved consumer service and verify message acknowledgement/queue drain.

**Validation:** Queue depth trends toward baseline and downstream telemetry catches up.