# NS-INC-04 — IIS Application Outage

## Objective
Diagnose and restore a synthetic internal application hosted on IIS without bypassing evidence collection or change control.

## Environment
- `NS-APP01` — IIS application server
- `NS-SQL01` — synthetic application database dependency
- `NS-DC01` / `NS-DC02` — identity and DNS
- `NS-CL-OPS01` — client

## Normal state
Clients resolve the application hostname, IIS accepts HTTPS requests, the application pool is healthy, and the application can reach its backing services.

## Fault injection
Use one controlled test condition:
- stop a dedicated application pool;
- stop a synthetic dependent service; or
- point a test-only health check at an unavailable endpoint.

## Expected symptoms
- HTTP 500/503 responses
- failed synthetic health checks
- application pool stopped
- user-reported application outage

## Detection
1. Synthetic HTTP health check fails.
2. Application log records an error.
3. Monitoring creates an alert when failures cross threshold.

## Investigation path
```text
Client -> DNS -> Firewall policy -> IIS listener -> App Pool -> Application -> Dependency
```

Check each layer in order. Do not restart the entire server before identifying the failing component.

## Recovery
1. Capture IIS/application evidence.
2. Confirm the affected application pool and dependency.
3. Apply the smallest safe recovery action.
4. Re-run the synthetic health check.
5. Validate from a client context.
6. Record recovery and monitoring state.

## Evidence
- HTTP status before/after
- IIS logs
- application event logs
- application pool state
- dependency checks
- recovery actions

## RCA template
Document trigger, technical cause, customer/operational impact, detection time, recovery time, and prevention.

## Skills demonstrated
IIS, Windows Server, application operations, SQL dependency awareness, monitoring, troubleshooting, incident response.
