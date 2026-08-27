# Northstar Build Order

This is the authoritative deployment sequence for the lab. Individual scripts may support plan or execution modes, but dependencies should be respected.

## Phase 0 — Host readiness

- Hyper-V available
- storage capacity confirmed
- installation media prepared
- lab-only addressing selected
- no overlap with production or external networks

## Phase 1 — Network foundation

1. Create Hyper-V virtual switches.
2. Create logical zone/VLAN mappings.
3. Deploy the firewall/router appliance.
4. Configure routing and only the required cross-zone policy.
5. Validate management access and basic segmentation.

## Phase 2 — Core identity

1. Deploy `DC01`.
2. Establish the synthetic domain and DNS service.
3. Deploy `DC02`.
4. Validate replication and DNS.
5. Create OU, group and synthetic user structure.

## Phase 3 — Enterprise services

1. `FS01` — file shares and role-based access.
2. `PRN01` — synthetic queues and printer service.
3. `APP01` — IIS/application workload.
4. `SQL01` — synthetic operational database workload.

## Phase 4 — Monitoring

1. Start Elasticsearch.
2. Start RabbitMQ.
3. Start telemetry consumer.
4. Start Kibana.
5. Configure ElastAlert2.
6. Add endpoint/log shippers.
7. Confirm baseline telemetry.

## Phase 5 — Client fleet

1. Create synthetic HQ clients.
2. Create Plant-East clients.
3. Create Plant-West clients.
4. Join endpoints to the domain.
5. Apply role/zone-appropriate configuration.
6. Generate baseline activity.

## Phase 6 — Operations validation

- DNS and identity
- file access
- print queues
- application health
- telemetry freshness
- alert delivery

## Phase 7 — Incident demonstrations

Run NS-INC-01 through NS-INC-05. Capture evidence and complete the scenario RCA template for each demonstration.
