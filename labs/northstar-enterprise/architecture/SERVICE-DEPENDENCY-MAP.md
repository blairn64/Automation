# Northstar Service Dependency Map

## Core dependencies

```text
                 +-------------------+
                 | OPNsense / Routing|
                 +---------+---------+
                           |
            +--------------+--------------+
            |                             |
      +-----v-----+                 +-----v-----+
      | Identity  |                 | Monitoring|
      | AD / DNS  |                 | Elastic   |
      +--+-----+--+                 +-----+-----+
         |     |                          |
 +-------+     +--------+                 |
 |                    |                   |
 v                    v                   v
Clients            Servers            Alerts/Evidence
                      |
          +-----------+-----------+
          |           |           |
          v           v           v
        APP01       PRN01        SQL01
          |
          +------ application dependency ------+
```

## Dependency rules
- Clients depend on network reachability and DNS for normal service discovery.
- Domain services depend on healthy AD/DNS infrastructure.
- Application services may depend on identity and data services.
- Monitoring should observe failures but should not become an inline dependency for the workload itself.
- Incident scenarios should isolate one dependency at a time where possible.

## Operational use
Use this map during triage to avoid random restarts. Start at the user-visible service, identify its immediate dependency, then validate each upstream dependency in sequence.
