# IIS application support

Small diagnostics for IIS-hosted applications.

## `Get-IISHealth.ps1`

Checks an application URL and, when run locally on an IIS host, reports the number of sites and application pools.

Example:

```powershell
.\Get-IISHealth.ps1 -Url 'http://localhost/'
```

This is deliberately diagnostic/read-only tooling. It does not restart services, recycle pools, change bindings, or modify IIS configuration.

## Troubleshooting path

1. Confirm DNS and TCP connectivity.
2. Test the application endpoint.
3. Check HTTP status and IIS logs.
4. Check application-pool state.
5. Check backend dependencies such as SQL/API services.
6. Compare the application failure with monitoring and event logs.
