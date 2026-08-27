# Azure Administration Lab Runbook

These exercises are designed as small, reproducible administration scenarios rather than a certification dump.

## Lab discipline

1. Use a disposable lab subscription.
2. Record the intended address space and resource naming before deployment.
3. Deploy only what the scenario requires.
4. Capture validation output.
5. Remove resources when finished.

## Evidence standard

For each lab, keep four things together:

- Objective and scenario
- PowerShell/Azure CLI used
- Validation result
- Teardown or rollback steps

## Security boundary

Never commit subscription IDs, tenant IDs, access tokens, credentials, private endpoints or organisation-specific configuration.

## Scenarios

### Resource inventory

Demonstrates discovering resources and producing an operator-friendly inventory.

### Networking

Demonstrates VNet/subnet design, segmentation, route planning and network security boundaries.

### VM operations

Demonstrates lifecycle operations, tagging, status checks and administrative scripting.

### Storage and monitoring

Demonstrates storage configuration, diagnostics and basic operational monitoring concepts.

## Portfolio note

These labs are intentionally generic. They demonstrate administrator workflows and automation patterns rather than claiming production ownership of an Azure environment.
