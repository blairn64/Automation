# Quality and Review

## Before merge

- Run PowerShell syntax checks and PSScriptAnalyzer.
- Confirm examples use placeholder identities and lab targets.
- Check that no secrets, certificates, tokens, tenant IDs, domains, hostnames or internal addresses are present.
- Prefer `-WhatIf`/`SupportsShouldProcess` for scripts that change directory state.
- Keep read-only audit tooling separate from remediation tooling.

## Design principles

- Parameterize environment-specific values.
- Fail clearly when prerequisites are missing.
- Produce structured output where practical.
- Keep authentication and secrets outside source control.
- Document required permissions and expected side effects.
