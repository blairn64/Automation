# Northstar Operational Tooling

These scripts provide reusable operational checks for the synthetic Northstar Enterprise Lab. They are designed to generate observable evidence and support controlled incident demonstrations.

## Scripts

### `Test-NorthstarHealth.ps1`
Checks reachability, DNS and selected TCP ports across core hosts and writes CSV/JSON evidence.

```powershell
.\Test-NorthstarHealth.ps1
```

### `Test-NorthstarServices.ps1`
Checks the state of mapped core services such as AD DS, DNS, Spooler, IIS and SQL Server.

```powershell
.\Test-NorthstarServices.ps1
```

### `Get-NorthstarEvidence.ps1`
Captures a timestamped incident evidence bundle.

```powershell
.\Get-NorthstarEvidence.ps1 -Scenario Application
```

### `Start-NorthstarSyntheticWorkload.ps1`
Generates JSONL events representing synthetic enterprise activity for ingestion and observability testing.

```powershell
.\Start-NorthstarSyntheticWorkload.ps1 -DurationSeconds 600 -IntervalSeconds 5
```

## Evidence structure

```text
labs/northstar-enterprise/evidence/
├── health/
├── services/
├── Telemetry/
├── IdentityDNS/
├── Print/
├── Application/
└── Capacity/
```

## Safety
These tools target the synthetic lab. Review host mappings before execution and avoid pointing fault-injection or administrative commands at systems you do not own or administer.
