# Public release checklist

Use this checklist before treating a repository change as portfolio-ready.

## Code

- [ ] The code runs, or the environment-specific requirement is clearly stated.
- [ ] Parameters are used and validated.
- [ ] Error messages are actionable.
- [ ] Tests or smoke checks cover the main path where practical.

## Documentation

- [ ] README explains purpose and scope.
- [ ] Run instructions match the current code.
- [ ] Fixture, simulation and live-integration boundaries are explicit.
- [ ] Links point to existing files.

## Security and privacy

- [ ] No credentials, tokens or private keys.
- [ ] No employer/client names or proprietary data.
- [ ] No private hostnames, tenant IDs or internal addresses.
- [ ] Sample data is synthetic or safe to publish.
- [ ] Logs and screenshots have been reviewed for accidental disclosure.

## GitHub quality

- [ ] Relevant Actions workflows are green.
- [ ] Failed historical runs are understood rather than ignored.
- [ ] New workflow permissions follow least privilege.
- [ ] Repository Security settings are reviewed after major changes.

## Presentation

- [ ] A first-time reader can identify what the project is within one minute.
- [ ] The strongest entry points are linked from the root README.
- [ ] Older or legacy material is honestly labelled.
