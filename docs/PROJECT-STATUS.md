# Project status

This repository is a working collection rather than one deployable product. Each area should be read according to its execution model.

## Execution labels

### Live integration
Code that can connect to a real service when the required authorised credentials, modules and environment are supplied. Credentials are intentionally not stored in the repository.

### Fixture/demo mode
Code designed to run locally against synthetic input so behaviour can be inspected without tenant, production or employer access.

### Simulation
A deliberately synthetic representation of an operational system used to exercise workflows, telemetry, troubleshooting or integration boundaries.

### Proof of concept
A focused experiment intended to demonstrate an approach rather than a complete production product.

## Current interpretation

- `m365/`, `entra/`, `exchange/` — live integration patterns with fixture/demo paths where provided.
- `enterprise-lab/`, `factory-lab/`, `incident-scenarios/` — simulations and reproducible scenarios.
- `it-ops/`, `windows/iis/`, `sql/health/`, `linux/`, `virtualization/` — operational tooling; some commands require the relevant local platform or vendor module.
- `monitoring/`, `security/`, `evidence-labs/` — demonstrations, fixtures and importable configuration examples.
- `api-auth/`, `message-queue/` — runnable application/integration labs subject to their documented dependencies.

## Quality expectations

Before presenting an area as active evidence, verify:

1. the README matches the current files;
2. commands are reproducible or clearly marked as environment-specific;
3. sample data is synthetic;
4. no secrets or private infrastructure details are present;
5. CI status is reviewed after material changes.

See `docs/QUALITY.md` and `SECURITY.md` for the repository-wide expectations.
