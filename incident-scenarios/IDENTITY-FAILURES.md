# Identity Failure Spike

**Symptoms:** Multiple users report authentication failures within the same time window.

**Evidence:** Group failures by user, site, client and timestamp; compare against recent policy/control changes.

**Isolation:** Determine whether the issue is user-specific, client-specific, site-specific or policy-wide.

**Recovery:** Apply the approved identity-change rollback/fix path, then validate with test users.

**Validation:** Failure rate returns toward baseline and unaffected populations remain healthy.