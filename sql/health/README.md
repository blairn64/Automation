# SQL Server Health Diagnostics

Read-only examples for investigating application-facing SQL Server issues.

## Focus

- Database inventory
- Session/blocking review
- Failed SQL Agent jobs
- Backup freshness
- Capacity and file growth
- Basic server health

Existing tooling includes `Get-SqlServerDiagnostic.ps1` for an authorised, read-only diagnostic snapshot.

## Troubleshooting path

Application slow -> endpoint health -> SQL connectivity -> active requests -> blocking/long-running work -> application/monitoring timestamps.

Runtime connection details only; no embedded credentials.