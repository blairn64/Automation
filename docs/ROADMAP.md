# Portfolio Roadmap

## Complete

- Sanitized PowerShell automation collection
- Entra / Microsoft Graph sign-in reporting pattern
- Exchange privilege auditing
- Active Directory lab onboarding
- Windows session monitoring
- Linux host health check
- REST API authentication example
- RabbitMQ-compatible producer/consumer lab
- Azure resource inventory lab
- PSScriptAnalyzer CI
- Technical documentation and publication rules

## Next improvements

1. Add Pester tests for the PowerShell tools.
2. Add structured JSON output to the audit/reporting tools where it adds value.
3. Add reusable Graph authentication helpers backed by environment variables or a secure certificate store.
4. Add secret scanning to CI.
5. Expand the Azure lab into networking, compute, storage, monitoring and backup exercises as real lab work is completed.
6. Add Elastic/Ansible examples only after each file has passed the same privacy and provenance review.

## Portfolio principle

Prefer a small number of useful, understandable tools over a large collection of disconnected snippets. Every public example should be runnable in a disposable lab and documented well enough for another engineer to understand the design.
