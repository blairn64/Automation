# VMware / Hyper-V operations lab

The CV experience around VMware and Hyper-V is represented here with vendor-neutral operational tasks rather than pretending to ship a hypervisor replica.

## Inventory tasks

- VM name, power state and guest OS reporting
- CPU/memory allocation review
- Snapshot age review
- Datastore/storage capacity checks
- Orphaned resource identification
- Guest-tools/integration-version checks
- Template lifecycle notes

## Safe operating model

Inventory and reporting are read-only by default. Changes such as deleting snapshots or powering off guests belong in an explicitly reviewed change process.
