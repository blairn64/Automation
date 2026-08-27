# Exchange privilege audit

Read-only PowerShell tooling for reviewing membership of a configurable Exchange role group.

## What it demonstrates

- Exchange Online PowerShell cmdlet usage
- Recursive role-group membership inspection
- Structured CSV output
- Explicit read-only scope for safer auditing
- Parameterized output paths for repeatable reporting

## Prerequisites

- PowerShell 7+
- ExchangeOnlineManagement module
- An authorised Exchange environment

The script assumes an authenticated Exchange PowerShell session. Authentication is intentionally not embedded in source code.

## Example

```powershell
Connect-ExchangeOnline
./Get-ExchangePrivilegeAudit.ps1 \
  -RoleGroup 'Organization Management' \
  -OutputPath './output/exchange-privilege-audit.csv'
```

## Safety

The script does not modify role membership. It should only be run against environments you are authorised to administer.

No real mailbox, tenant, organisation or user data is included in this repository.
