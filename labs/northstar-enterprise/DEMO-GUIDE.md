# Northstar Enterprise Lab — Demo Guide

## Goal
Demonstrate the environment as an operational system, not as a slideshow of virtual machines.

## 10-minute walkthrough

### 1. Architecture — 1 minute
Show `architecture/ENTERPRISE-ARCHITECTURE.md` and explain the synthetic enterprise layers: edge, identity, business services, telemetry and monitoring.

### 2. Identity — 1 minute
Show the OU and account model. Explain standard users, separate administration and service identities.

### 3. Services — 2 minutes
Use the server/service catalogue and health tooling to demonstrate the relationship between DCs, file, print, IIS/application, SQL and monitoring.

### 4. Telemetry — 2 minutes
Generate synthetic workload data, then explain the pipeline:

```text
Producer -> RabbitMQ -> Consumer -> Elasticsearch -> Kibana -> ElastAlert 2
```

### 5. Incident — 3 minutes
Pick one scenario and walk through:
- baseline;
- symptom;
- detection;
- evidence capture;
- dependency investigation;
- recovery;
- validation;
- RCA.

### 6. Close — 1 minute
Show that the repo contains:
- architecture;
- automation;
- operational checks;
- incident scenarios;
- troubleshooting;
- monitoring catalogue;
- evidence tooling.

## Recommended demo commands

```powershell
# Generate synthetic data
.\scripts\New-NorthstarWorkloadData.ps1 -Events 100

# Validate dependencies after recovery
.\scripts\Test-NorthstarRecovery.ps1

# Create a scenario evidence record
.\scripts\Invoke-NorthstarScenario.ps1 -Scenario NS-INC-04 -Mode Validate
```

## Demonstration principle
Never claim the lab represents a copied employer environment. It demonstrates transferable architecture and operations practices using a synthetic environment.
