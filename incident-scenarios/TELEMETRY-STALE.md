# Stale Factory Telemetry

**Symptoms:** Application is healthy but production metrics stop changing.

**Evidence:** Compare latest source timestamp, ingestion time, queue activity and processed record timestamp.

**Isolation:** Establish whether the fault is at the source, network, queue, consumer, storage or reporting layer.

**Recovery:** Restore the failed component through the approved change path and validate catch-up behaviour.

**Validation:** New telemetry arrives end-to-end and reported values match the source.