# Portfolio Roadmap

## Current

- Sanitized PowerShell automation collection
- Entra/Graph sign-in reporting pattern
- Exchange privilege auditing
- Active Directory lab onboarding
- Windows session monitoring
- Technical documentation and publication rules

## Next

1. Add Pester tests for input validation and report generation.
2. Add a reusable Microsoft Graph authentication helper that reads configuration from environment variables or a secure certificate store.
3. Add structured JSON output alongside HTML/CSV reports.
4. Add CI linting for PowerShell formatting and secret scanning.
5. Add Linux/Bash and Elastic tooling after the infrastructure repositories have been fully audited.
6. Link selected examples from the profile README once the public repositories are final.

## Portfolio principle

Prefer a small number of useful, understandable tools over a large collection of disconnected snippets. Every public example should be runnable in a disposable lab and documented well enough for another engineer to understand the design.
