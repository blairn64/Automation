# Northstar Build Runbook

## Phase 0 — Host preparation

- Enable Hyper-V.
- Confirm storage capacity.
- Create an isolated lab area.
- Decide whether the lab uses NAT-only internet access or a dedicated physical NIC.
- Do not bridge management interfaces to an untrusted network.

## Phase 1 — Networking

Run:

```powershell
./hyperv/New-NorthstarNetwork.ps1
```

Verify every switch exists before creating guests.

## Phase 2 — Core guests

Recommended first guests:

1. `NS-HQ-FW01` — OPNsense
2. `HQ-DC01` — AD/DNS
3. `HQ-MGMT01` — admin/jump host
4. one Windows client
5. one Linux server

## Phase 3 — Enterprise services

Add as required:

- `HQ-DC02`
- `HQ-FS01`
- `HQ-PRN01`
- `HQ-APP01`
- `HQ-WEB01`
- `HQ-SQL01`

## Phase 4 — Monitoring

Bring up the Elastic and monitoring profile. Verify ingestion before enabling detection rules.

## Phase 5 — Detection

Deploy the ElastAlert 2 configuration and test one rule against known synthetic events. Do not jump straight to “production-style” alerting without a known-good event path.

## Phase 6 — Incident drills

Start with `INC-001-rabbitmq-telemetry-backlog.md`.

## Acceptance checklist

- [ ] DNS resolves core lab hosts
- [ ] Users receive expected network configuration
- [ ] Management access is restricted to the management zone
- [ ] Users cannot directly reach prohibited management ports
- [ ] Telemetry reaches Elastic
- [ ] Detection rules can be tested
- [ ] At least one incident completes end-to-end
- [ ] Recovery evidence is documented
