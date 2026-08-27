# Azure Networking Lab

## Objective

Demonstrate the core Azure networking concepts expected of an administrator: virtual networks, subnets, route planning and network security boundaries.

## Scenario

Create a small two-subnet lab:

```text
Virtual Network
├── management subnet
└── workload subnet
```

The lab should deliberately keep management and workload traffic separate and document the intended security boundary before deployment.

## Evidence to capture

- VNet/subnet configuration
- Effective security rules
- Address-space plan
- Azure CLI or PowerShell commands used
- A short note explaining why each subnet exists

No real subscription IDs or production addresses belong in Git.
