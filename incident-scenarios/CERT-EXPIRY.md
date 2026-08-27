# Certificate Expiry

**Symptoms:** HTTPS endpoint starts failing after certificate expiry.

**Evidence:** Inspect certificate validity, binding, hostname and server/application logs.

**Isolation:** Confirm whether failure is TLS-specific or an upstream application issue.

**Recovery:** Renew/install the approved certificate and update the correct binding.

**Validation:** Endpoint establishes TLS successfully and dependent clients recover.

**Prevention:** Monitor certificate expiry windows and record ownership/renewal paths.