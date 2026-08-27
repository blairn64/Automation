# Network Segmentation Failure

**Symptoms:** A service is healthy locally but unreachable from the expected application segment.

**Evidence:** Verify source/destination/service, DNS, route and TCP connectivity against the intended policy.

**Isolation:** Separate name resolution, routing, firewall policy and service-listening issues.

**Recovery:** Correct the approved network policy/change, then re-test from the original source segment.

**Validation:** Required flow works while unrelated traffic remains blocked.