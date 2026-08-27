# Linux Administration

Small, defensive Bash utilities for Linux administration and operational checks.

## Goals

- Prefer predictable exit codes and readable output.
- Avoid destructive behaviour in public examples.
- Keep paths, hosts and credentials configurable.
- Make scripts usable from SSH, cron or a monitoring agent.

## Included

`health-check.sh` reports hostname, uptime, load, memory, disk usage and failed systemd units.

## Example

```bash
chmod +x health-check.sh
./health-check.sh
```

Use these examples only on systems you own or are authorised to administer.
