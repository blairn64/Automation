# INC-002 — Identity and DNS Failure

## Scenario

A controlled fault causes a branch of the lab to resolve an incorrect DNS server. Authentication-dependent services begin failing intermittently.

## Story

1. `HQ-CL01` receives an incorrect DNS setting during a controlled test.
2. Users report login/application failures.
3. Synthetic tickets are generated.
4. Monitoring records service symptoms.
5. Elastic investigation correlates client and infrastructure events.
6. Engineer identifies DNS configuration as the common dependency.
7. Correct configuration is restored.
8. Authentication and application checks recover.

## Evidence to capture

- `ipconfig /all` equivalent before/after
- DNS query failure/success
- relevant server/client events
- alert/ticket timeline
- remediation command or configuration change
- validation after recovery

## Root-cause format

**Impact:** synthetic users unable to reach authentication-dependent services reliably.

**Trigger:** controlled DNS misconfiguration.

**Detection:** user symptoms plus monitoring/telemetry.

**Root cause:** incorrect resolver configuration on the affected client segment.

**Corrective action:** restore the approved DNS configuration and validate resolution/authentication.

**Preventive action:** configuration validation and monitoring for unexpected resolver changes.
