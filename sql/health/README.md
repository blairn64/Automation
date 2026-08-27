# SQL Server diagnostics

`Get-SqlServerDiagnostic.ps1` collects basic SQL Server instance information and a read-only snapshot of active requests ordered by elapsed time.

Example:

```powershell
.\Get-SqlServerDiagnostic.ps1 -Instance 'localhost'
```

This is intended for authorised troubleshooting and does not change databases, kill sessions, or modify configuration.

## Troubleshooting path

Application slow -> confirm endpoint health -> inspect SQL connectivity -> review active requests -> identify blocking/long-running work -> correlate with application and monitoring timestamps.
