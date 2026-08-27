# Network Administration Lab

A generic network-operations lab covering the pieces listed on the CV that should remain demonstrable without exposing a real environment.

## Firewall

Example policy goals:

- Default-deny inbound posture
- Allow established/related traffic
- Permit only explicitly required management/application ports
- Log denied traffic for troubleshooting

## VPN

Use a disposable WireGuard lab to demonstrate peer configuration, routing, key separation and connectivity testing.

## DNS/DHCP

Use a local dnsmasq lab to provide test DNS records and DHCP leases. Validate with `dig`, `resolvectl`, `ip addr` and lease inspection.

## Segmentation

Model production-style separation as distinct VLANs/subnets such as:

- Management
- Application/server
- Telemetry/OT simulation
- User/client

The lab is conceptual and uses fictional addressing only.
