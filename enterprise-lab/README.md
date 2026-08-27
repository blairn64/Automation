# Enterprise Operations Lab — 5,000 Users / Multi-Site Manufacturing

A synthetic end-to-end environment that reproduces the *operating model* of a large manufacturing estate: thousands of users, multiple sites, Microsoft-style identity, factory IT/OT networks, production application services, SQL data, messaging, monitoring and support workflows.

This is a clean-room portfolio lab. It contains no employer/client data, credentials, tenant identifiers or proprietary configuration.

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

## Scale model

The lab includes synthetic data generation for **5,000 users**, multiple manufacturing sites, assets, support events and telemetry streams. The number is intentionally large enough to exercise filtering, batching, reporting and operational triage patterns without using real records.

## What an engineer can demonstrate

### Identity and user operations

- Provision/report users at thousands-of-user scale.
- Generate synthetic sign-in and authentication events.
- Analyse access activity by site and user population.
- Separate identity telemetry from remediation actions.

### Manufacturing IT/OT

- Treat factory networks as segmented zones.
- Represent PLC-connected machines and sensors with simulators.
- Move telemetry through an explicit ingestion boundary.
- Trace an operational value from source device through queue, processing and reporting.

### Application and data support

- Represent an IIS-style application tier.
- Store production-style records in SQL.
- Model an external SAP-style integration boundary without reproducing vendor-specific proprietary interfaces.
- Diagnose failures across application, database, network and messaging layers.

### Monitoring and incident response

- Produce health signals from application, host, queue and telemetry layers.
- Generate synthetic alerts and classify severity.
- Investigate queue backlog, unavailable services, stale data and threshold breaches.
- Keep detection separate from remediation.

## Interview scenarios

1. A single factory line stops reporting telemetry while the rest of the site remains healthy.
2. The application is reachable but SQL data is stale.
3. RabbitMQ backlog grows because a consumer is unavailable.
4. A user population reports authentication failures after an identity-policy change.
5. A network segment blocks a required application-to-database path.
6. Production KPI data differs from source sensor values and needs end-to-end tracing.
7. Monitoring generates too many alerts and thresholds require tuning.
8. A site loses connectivity while local production services continue operating.

## Design goals

- Synthetic data only.
- No destructive automation by default.
- Runtime configuration rather than embedded secrets.
- Reproducible local execution.
- Explicit separation between IT and OT responsibilities.
- Clear evidence of troubleshooting, automation and operational reasoning.
