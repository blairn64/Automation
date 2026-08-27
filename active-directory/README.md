# Active Directory user preparation

A parameterized PowerShell example for preparing a disabled lab user and optionally assigning group membership.

## What it demonstrates

- Active Directory PowerShell cmdlets
- Parameter validation through a reusable command interface
- `Set-StrictMode` and fail-fast error handling
- `ShouldProcess` support for `-WhatIf`
- Generic OU and group configuration without embedded infrastructure data

## Example

```powershell
./New-LabUser.ps1 `
  -SamAccountName 'jdoe' `
  -GivenName 'Jane' `
  -Surname 'Doe' `
  -UserPrincipalName 'jdoe@example.invalid' `
  -WhatIf
```

Remove `-WhatIf` only when operating in an authorised lab or test domain.

## Scope

This is intentionally a preparation example. Production onboarding would normally separate identity creation, Exchange/hybrid provisioning, licensing and access reviews into controlled workflow stages.

No real directory paths, users, domains or company information are included.
