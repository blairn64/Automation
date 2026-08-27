# Entra sign-in monitor

A PowerShell/Microsoft Graph example for reviewing recent successful sign-ins across one or more authorised Microsoft Entra tenants and highlighting activity outside an allowlist of countries.

## What it demonstrates

- Microsoft Graph authentication with an application certificate
- Multi-tenant iteration
- Sign-in log filtering with Graph OData filters
- Defensive HTML encoding before report generation
- Structured error handling per tenant
- HTML reporting suitable for operational review

## Prerequisites

- PowerShell 7+
- Microsoft Graph PowerShell SDK with the required audit-log permissions
- An application registration configured for the authorised lab tenant(s)
- Certificate-based authentication configured for that application

## Example

```powershell
$env:GRAPH_CLIENT_ID = 'YOUR-CLIENT-ID'
$env:GRAPH_CERT_THUMBPRINT = 'YOUR-CERT-THUMBPRINT'

./Invoke-TenantSignInMonitor.ps1 `
  -TenantIds @('YOUR-TENANT-ID') `
  -HoursBack 24 `
  -AllowedCountries @('GB','IE') `
  -OutputPath './output/sign-ins.html'
```

Do not place real tenant IDs, usernames, certificate material or mailbox addresses in the repository.

## Portfolio note

This is a sanitized portfolio implementation of a common identity-monitoring workflow. It is not connected to any employer or customer environment.
