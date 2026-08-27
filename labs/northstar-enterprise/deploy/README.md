# Northstar Deployment Automation

This folder is the reproducibility layer for the Northstar synthetic enterprise lab.

## Build sequence
1. Create Hyper-V switches.
2. Create/import VM inventory.
3. Attach workloads to the correct segment.
4. Bootstrap identity services.
5. Apply server role configuration.
6. Deploy telemetry and monitoring services.
7. Run health validation.

## Safety
All values are synthetic defaults. Review VM paths, ISO paths, switch names and credentials before execution. Scripts should support `-WhatIf` where the underlying cmdlets support it and should never contain real tenant, employer or client data.

## Files
- `New-NorthstarVmPlan.ps1` — emits the planned VM inventory and configuration.
- `Test-NorthstarDeployment.ps1` — validates required hosts and service ports after deployment.

The deployment plan is intentionally separated from scenario fault injection so build and incident testing remain distinct operational activities.
