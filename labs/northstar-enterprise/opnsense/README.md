# OPNsense Deployment

`NS-HQ-FW01` is the routing and policy boundary for the Northstar lab.

OPNsense supports Hyper-V virtual machines, and its documentation notes that Generation 1 and Generation 2 VMs are supported; for Hyper-V deployments, disable Secure Boot in the VM hardware/security configuration. citeturn0search9

## VM interfaces

Attach one adapter per lab zone you want to route. Start small:

- WAN / upstream NAT
- `NS-SERVERS`
- `NS-CORP-USERS`
- `NS-INFRA-MGMT`
- `NS-DMZ`
- `NS-MONITORING`
- `NS-OT`

Add print/IoT and guest when those scenarios need them.

## Policy model

Default posture: **deny between zones unless a documented service path requires access**.

Examples:

| Source | Destination | Purpose |
|---|---|---|
| Corporate users | AD/DNS/DHCP | Core identity services |
| Corporate users | Published app services | Business applications |
| Management | Servers | Approved administration |
| Monitoring | Managed systems | Telemetry collection |
| OT | RabbitMQ/telemetry endpoint | Production-style telemetry |
| DMZ | App dependency | Explicit application path |
| Guest | Internal networks | Deny |

## Do not copy this blindly

Firewall rules depend on your host, lab internet design and guest operating systems. Keep credentials, VPN keys and API tokens out of Git. This repository documents architecture and repeatable intent, not a drop-in production firewall export.
