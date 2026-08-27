# Zabbix Monitoring Lab

This lab documents a practical monitoring pattern for infrastructure and production-adjacent systems.

## Checks

- Host availability
- CPU and memory pressure
- Filesystem utilisation
- Service/process state
- Application endpoint availability

## Operating model

Monitoring should produce actionable events, not a stream of noise. Thresholds should be reviewed against normal baselines and escalated according to service impact.

The example is generic and contains no production hosts or monitoring identifiers.
