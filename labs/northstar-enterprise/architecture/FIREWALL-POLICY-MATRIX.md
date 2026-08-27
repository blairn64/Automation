# Northstar Firewall Policy Matrix

Northstar uses a deny-by-default segmentation model. Rules below describe the intended synthetic lab architecture; they are not copied from any employer environment.

| Source | Destination | Service | Purpose | Default |
|---|---|---|---|---|
| Management VLAN | Infrastructure VLAN | HTTPS/SSH/RDP as required | Administration | Allow explicitly |
| User VLAN | AD/DNS | DNS/Kerberos/LDAP as required | Identity services | Allow explicitly |
| User VLAN | Application VLAN | HTTPS | Internal applications | Allow explicitly |
| Application VLAN | Data VLAN | Required database port only | Application dependency | Allow explicitly |
| Monitoring VLAN | Managed assets | Approved telemetry ports | Collection | Allow explicitly |
| User VLAN | Management VLAN | Any | Prevent lateral admin access | Deny |
| Guest/Test VLAN | Internal enterprise VLANs | Any | Isolation | Deny |
| Internet | Internal services | Any unsolicited inbound | Edge protection | Deny |

## Rule design principles
1. Default deny between segments.
2. Permit only documented service flows.
3. Use named aliases/groups rather than scattered individual addresses where the platform supports them.
4. Keep management access separate from user access.
5. Log deny events that are useful for investigation without creating uncontrolled noise.
6. Review rules after architecture changes.

## Validation checklist
- Client can resolve and authenticate to approved identity services.
- Client can reach published application endpoints.
- Client cannot reach management interfaces.
- Application server can reach only required data services.
- Monitoring components can collect approved telemetry.
- Unapproved lateral flows are blocked.
