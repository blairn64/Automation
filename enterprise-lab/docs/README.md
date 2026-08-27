# Enterprise Lab Documentation

This directory explains the synthetic enterprise environment and how to discuss it in interviews.

- `ARCHITECTURE.md` — system layers and data flow.
- `OPERATIONS-RUNBOOK.md` — incident scenarios and troubleshooting order.
- `SCALE.md` — synthetic scale dimensions and CV mapping.

## Demonstration sequence

1. Run `python enterprise-lab/run-all.py` to generate the 5,000-user estate, sign-in telemetry and service-desk workload.
2. Run the existing `factory-lab` simulator and worker to produce telemetry through RabbitMQ/AMQP.
3. Use the generated datasets to exercise identity, support-volume, production-data and monitoring scenarios.
4. Trace a simulated incident across network, application, queue, database and observability layers.

The project is deliberately a simulator. It demonstrates architecture and operational practice without reproducing confidential workplace implementation details.
