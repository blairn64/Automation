# NS-INC-03 — Print Service Outage

## Objective
Restore printing for the Operations department after users report that jobs remain queued and production paperwork cannot be printed.

## Environment
- `NS-PRN01` — Windows print server
- `NS-DC01` / `NS-DC02` — DNS and directory services
- `NS-CL-OPS01` — Operations client
- `OPS-PRN-01` — synthetic network printer endpoint

## Normal state
The Print Spooler service is running, the Operations queue is published, clients resolve the print server through DNS, and jobs move from queue to completed state.

## Fault injection
Stop the spooler service on the synthetic print server or place the test printer endpoint into an unavailable state.

## Expected symptoms
- Jobs remain in the queue
- Users receive printer unavailable or stalled-job errors
- Operations paperwork is delayed

## Detection
1. User report or service desk ticket.
2. Monitor detects repeated print failures or a stopped spooler service.
3. Operator confirms queue depth and service state.

## Investigation
```text
Client -> DNS -> NS-PRN01 -> Print Spooler -> Queue -> Printer endpoint
```

Check:
1. Client network connectivity.
2. DNS resolution for `NS-PRN01`.
3. Print Spooler service.
4. Queue depth and stuck jobs.
5. Printer endpoint connectivity.
6. Recent service or configuration changes.

## Recovery
1. Preserve evidence of queue state and relevant logs.
2. Restart the spooler where appropriate.
3. Clear only confirmed stuck test jobs.
4. Validate the endpoint.
5. Submit a synthetic test page.
6. Confirm users can print again.

## Evidence
Capture:
- Service status before/after
- Queue depth
- Event log excerpts
- DNS result
- Test print result
- Recovery timestamp

## RCA template
- **Trigger:**
- **Impact:**
- **Detection gap:**
- **Root cause:**
- **Recovery:**
- **Preventive action:**

## Skills demonstrated
Windows Server, DNS, service troubleshooting, print operations, monitoring, evidence collection, root-cause analysis.
