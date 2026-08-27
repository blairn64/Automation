# Enterprise IT/OT Operations Lab

A synthetic, reproducible enterprise environment designed to demonstrate the scale and breadth of infrastructure support described in my professional experience.

## Scope

The lab models:

- 5,000 synthetic users across multiple sites
- Microsoft 365 / Entra-style identity activity
- service-desk tickets and escalation paths
- corporate, DMZ, application, production and OT network zones
- IIS-style application hosting
- SQL-backed production data
- an SAP-style integration boundary
- PLC/machine and sensor telemetry
- RabbitMQ/AMQP messaging
- Elastic-style logging and operational dashboards

## Architecture

```text
                           INTERNET / REMOTE USERS
                                      |
                              Identity / SSO Layer
                                      |
                 +--------------------+--------------------+
                 |                                         |
          Microsoft-style IT                         Service Desk
        Entra / M365 / MFA /                           / API queue
        access reporting                                  |
                 |                                         |
                 +--------------------+--------------------+
                                      |
                             Core Network / FW
                                      |
             +------------------------+------------------------+
             |                        |                         |
        SITE-A / NORTH           SITE-B / CENTRAL          SITE-C / SOUTH
             |                        |                         |
        Factory VLANs            Factory VLANs             Factory VLANs
             |                        |                         |
       App / SQL / OT           App / SQL / OT            App / SQL / OT
             |                        |                         |
       PLC + sensors             PLC + sensors              PLC + sensors
             \________________________|_________________________/
                                      |
                               RabbitMQ / AMQP
                                      |
                         Processing / normalisation
                             /         |          \
                          SQL       Elastic      KPI data
                             \         |          /
                               Monitoring / reports
```

## Scale

The environment is deliberately sized at **5,000 synthetic users** to demonstrate batching, reporting, triage and administration at realistic enterprise scale. Generated records are fictional and contain no employer/client information.

## Operating model

### Identity and M365

Synthetic identities generate sign-in activity, device associations and support events. The lab demonstrates reporting, filtering, access review and incident triage rather than connecting to a real tenant.

### Factory IT/OT

Each site contains separated corporate, application, production and OT zones. PLCs, machines, scales and sensors are represented by simulators. Telemetry crosses a controlled ingestion boundary before being processed and reported.

### Application and SQL support

An IIS-style application tier represents production web services. SQL stores operational records. An SAP-style boundary represents business-system integration without reproducing proprietary vendor interfaces.

### Monitoring and service desk

Synthetic telemetry produces alerts and service-desk events. Incidents can be followed from initial user report through identity, network, application, database or queue troubleshooting to resolution and root-cause notes.

## Failure scenarios

1. Authentication failures for a subset of users.
2. IIS application pool or endpoint failure.
3. SQL connectivity or stale-data condition.
4. RabbitMQ queue backlog or unavailable consumer.
5. Factory VLAN segmentation blocking a dependency.
6. Sensor/scale data outside an expected range.
7. Elastic ingestion delay or missing telemetry.
8. Monitoring threshold causing alert noise.
9. Site-to-core connectivity loss with local factory services remaining available.
10. Data mismatch between source telemetry and KPI reporting.

## Run

```bash
python enterprise-lab/generate-users.py
python enterprise-lab/generate-signins.py
python enterprise-lab/generate-tickets.py
python enterprise-lab/run-all.py
```

## Portfolio boundary

This is a **clean-room demonstration of the engineering model**, not a copy of a former employer's environment. No production credentials, client records, private hostnames, tenant identifiers or proprietary configuration are included.
