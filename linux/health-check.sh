#!/usr/bin/env bash
set -euo pipefail

printf '%s\n' '=== Linux Health Check ==='
printf 'Hostname: %s\n' "$(hostname)"
printf 'Kernel:   %s\n' "$(uname -sr)"
printf 'Uptime:   %s\n' "$(uptime -p 2>/dev/null || uptime)"
printf 'Load:     %s\n' "$(awk '{print $1, $2, $3}' /proc/loadavg)"

printf '\nMemory:\n'
free -h || true

printf '\nDisk:\n'
df -hT --exclude-type=tmpfs --exclude-type=devtmpfs || true

if command -v systemctl >/dev/null 2>&1; then
  printf '\nFailed systemd units:\n'
  failed="$(systemctl --failed --no-legend --no-pager 2>/dev/null || true)"
  if [[ -n "$failed" ]]; then
    printf '%s\n' "$failed"
  else
    printf '%s\n' 'None'
  fi
fi
