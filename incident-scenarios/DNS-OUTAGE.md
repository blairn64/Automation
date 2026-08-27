# DNS Dependency Failure

**Symptoms:** Application host is up but a dependency name no longer resolves.

**Evidence:** Query the expected record, compare authoritative response and inspect recent DNS/configuration changes.

**Isolation:** Distinguish name-resolution failure from routing or service failure by testing the resolved address and TCP path separately.

**Recovery:** Restore the approved DNS record/configuration and flush only where appropriate.

**Validation:** Resolution and dependent application connectivity both recover.