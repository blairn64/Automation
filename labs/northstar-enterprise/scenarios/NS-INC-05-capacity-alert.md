# NS-INC-05 — Infrastructure Capacity Alert

## Objective
Demonstrate proactive detection and controlled remediation of a capacity issue before it becomes a service outage.

## Environment
- Northstar server fleet
- Elastic monitoring pipeline
- optional host-level operational metrics
- controlled synthetic workload generator

## Normal state
Capacity remains within agreed thresholds and monitoring retains sufficient headroom for normal workload variation.

## Fault injection
Generate a bounded synthetic workload that increases one resource on a test host, such as disk consumption in a dedicated test directory or CPU activity from a controlled test process.

## Alert conditions
Example categories:
- sustained CPU pressure
- sustained memory pressure
- low free disk space
- abnormal queue depth

Thresholds should be treated as examples and tuned to the lab baseline rather than copied blindly.

## Investigation
1. Confirm alert source and timestamp.
2. Compare current metrics with baseline.
3. Identify the process, queue, or data path responsible.
4. Determine whether pressure is transient or sustained.
5. Assess service impact and available headroom.

## Recovery
- stop or reduce the synthetic workload;
- reclaim only test data created for the scenario;
- confirm metrics return toward baseline;
- close the alert only after validation.

## Evidence
Capture:
- alert payload
- baseline versus peak metrics
- responsible process/workload
- remediation timestamp
- post-recovery metrics

## RCA template
- Detection source
- Trigger
- Capacity constraint
- Why threshold was crossed
- Impact avoided or experienced
- Remediation
- Preventive tuning/action

## Skills demonstrated
Monitoring, alert tuning, capacity management, operational troubleshooting, evidence-driven incident response, RCA.
