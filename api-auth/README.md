# REST API and Authentication Patterns

Small examples showing how I structure API integrations: configuration from the environment, explicit timeouts, error handling and token handling without storing secrets in source control.

## Design goals

- Keep credentials outside Git.
- Use HTTPS for real services.
- Fail clearly on non-success responses.
- Keep authentication separate from application logic.
- Log useful operational information without dumping tokens.

The examples use placeholders only and should be pointed at a lab or service you are authorised to access.
