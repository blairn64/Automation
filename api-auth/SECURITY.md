# API Authentication Security

The examples in this directory demonstrate authenticated HTTP requests without storing credentials in source control.

## Token handling

Pass access tokens at runtime. Do not place bearer tokens in scripts, README files, command history copied into documentation, or test fixtures.

For real integrations:

- use HTTPS
- request the narrowest practical API permissions
- store secrets in the platform's secret store
- rotate credentials
- do not print authorization headers
- use short-lived tokens where supported

The portfolio example accepts an access token as a parameter solely to make the authentication boundary obvious. A production implementation should generally obtain and cache tokens through the service's supported identity mechanism rather than asking an operator to paste a long-lived secret into a command line.
