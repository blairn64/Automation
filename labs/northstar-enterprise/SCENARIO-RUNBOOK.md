# Northstar Enterprise Lab — Scenario Runbook

## Standard run sequence

```text
Baseline → Inject → Detect → Capture → Investigate → Recover → Validate → RCA
```

Use the scenario documentation as the authoritative description and the helper scripts as repeatable execution aids.

## Before every scenario

```powershell
# Generate a baseline where appropriate
.\scripts\Test-NorthstarHealth.ps1
.\scripts\Test-NorthstarServices.ps1
```

Create an evidence directory and record the scenario start time.

## NS-INC-01 — Telemetry backlog

```powershell
.\scenarios\scripts\NS-INC-01-TelemetryBacklog.ps1 -Mode Validate
.\scripts\Get-NorthstarEvidence.ps1
.\scenarios\scripts\NS-INC-01-TelemetryBacklog.ps1 -Mode Recover
.\scripts\Test-NorthstarRecovery.ps1
```

Validate producer, queue, consumer and indexing stages independently.

## NS-INC-02 — Identity/DNS
Validate reachability, DNS, time, authentication and directory dependencies before recovery. Do not use credentials or real directory data in scenario artefacts.

## NS-INC-03 — Print outage
Validate queue state, spooler health, server reachability and printer/network dependency. Confirm a synthetic print workflow after recovery.

## NS-INC-04 — IIS/application outage
Validate DNS, TCP reachability, IIS/application pool state, application logs and downstream dependencies. Confirm an application request after recovery.

## NS-INC-05 — Capacity alert
Validate the threshold, growth source and service impact. Recover capacity safely, then confirm monitoring returns to a healthy state.

## Evidence structure

```text
scenario-run/
├── 00-baseline/
├── 01-detection/
├── 02-investigation/
├── 03-recovery/
├── 04-validation/
└── RCA.md
```

## Closure criteria
A scenario is not complete until:
- the technical service is healthy;
- user/service validation succeeds;
- monitoring reflects recovery;
- evidence is captured;
- root cause and preventative action are documented.
