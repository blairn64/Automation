# Security policy

## Scope

This repository contains personal lab work, clean-room demonstrations, fixtures and operational tooling. It must not contain employer/client data, production credentials, private endpoints, internal hostnames or proprietary configuration.

## Reporting a problem

If you find a security issue in this repository, do not post credentials or exploit details in a public issue. Open a minimal issue describing the affected area and the impact without publishing sensitive material. The issue can then be taken offline if needed.

## Repository hygiene

- Keep secrets out of source control.
- Use environment variables or GitHub Actions secrets for runtime credentials.
- Commit `.env.example` files only; never real `.env` files.
- Use synthetic or fixture data for demonstrations.
- Keep workflow permissions to the minimum required.
- Review logs before sharing them.
- Rotate a credential immediately if it is ever committed or exposed.

## Supported code

The actively developed material is primarily in `Automation`. Older repositories are retained as historical projects and may use legacy dependencies or APIs.
