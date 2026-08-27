# SQL Blocking / Application Latency

**Symptoms:** Application remains reachable but requests become slow or time out.

**Evidence:** Check application timestamps, SQL connectivity, active requests, blocking and resource pressure.

**Isolation:** Identify the blocking chain and establish whether it matches the time window of the user impact.

**Recovery:** Use the approved database/change process to address the blocking workload; do not terminate sessions blindly.

**Validation:** Requests return to normal latency and monitoring confirms recovery.