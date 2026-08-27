# Simulation Components

The lab intentionally substitutes safe software simulators for production equipment.

| Production role | Lab substitute | Purpose |
| --- | --- | --- |
| Factory PLC | PLC/tag simulator | Represents machine state and counters |
| Industrial sensors | Python event generator | Produces temperature/pressure/state values |
| Industrial scales | Weight metric generator | Produces synthetic weights/counts |
| IIS application | Flask web service | Demonstrates application-tier support |
| SQL Server | SQL schema/relational test database | Demonstrates persistence and consistency checks |
| SAP | Integration adapter | Demonstrates business-system boundary |
| Factory subnet | Isolated Docker/network zone | Demonstrates segmentation and allowed flows |
| RabbitMQ | RabbitMQ container | Demonstrates asynchronous transport |
| SIEM | Structured JSON output | Demonstrates ingest/alert pipeline |

## Failure injection

The environment should support controlled failures such as:

- stop the consumer while producers continue publishing;
- make the database unavailable;
- return HTTP 503 from the application service;
- inject an out-of-range sensor value;
- deny a simulated network path;
- delay telemetry processing.

The objective is to demonstrate diagnosis and recovery without touching a live industrial control system.

## Safety boundary

Never point these examples at a real PLC, factory subnet, production database, corporate API or enterprise broker without explicit written authorization and an approved test plan.
