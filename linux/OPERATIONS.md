# Linux Operations Notes

The Linux examples are intentionally small. They are meant to be easy to run over SSH and easy to adapt into cron or a monitoring check.

## Health check

`health-check.sh` reports:

- hostname and kernel
- uptime
- system load
- memory usage
- mounted filesystems
- failed systemd units

The script uses `set -euo pipefail` and avoids changing system state.

## Operational pattern

For a larger host-management toolkit, keep collection separate from remediation:

```text
collection -> structured result -> threshold/rule -> optional action
```

That makes it easier to test collection logic without accidentally changing a machine.

## Safety

Do not hard-code production hostnames, IPs, usernames, passwords, private keys or internal paths. Test scripts against disposable lab systems first.
