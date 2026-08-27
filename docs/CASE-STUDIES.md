# Engineering Case Studies

These examples are deliberately small, but each one reflects a common infrastructure problem: collect operational data, validate it, transform it into useful output, and keep environment-specific details outside source control.

## Identity reporting

**Problem:** Authentication logs are useful only when they can be filtered into something an administrator can review.

**Approach:** Query Microsoft Graph for recent successful sign-ins, apply a configurable country allowlist, normalize the useful fields, and emit a portable HTML report.

**Engineering points:** runtime authentication, parameterized configuration, bounded lookback windows, structured findings, and explicit failure handling.

## Privilege auditing

**Problem:** Role membership can drift over time and privileged access needs a reviewable record.

**Approach:** Export recursive membership of a selected Exchange role group to CSV without changing the environment.

**Engineering points:** read-only by design, reproducible output, and separation of audit from remediation.

## Directory onboarding

**Problem:** User creation is repetitive and easy to get wrong when performed manually.

**Approach:** Use a parameterized PowerShell function with `ShouldProcess` support, an intentionally fake lab OU, and optional group assignment.

**Engineering points:** safe defaults, explicit side effects, input validation, and lab-first testing.

## Queue-based work

**Problem:** Some operational work should be decoupled from the process that requests it.

**Approach:** Publish a small JSON job to an AMQP-compatible queue and process it asynchronously with a consumer using acknowledgements and prefetch control.

**Engineering points:** durable messages, environment-based broker configuration, explicit acknowledgement, and a disposable Docker lab.

## Linux health checks

**Problem:** A lightweight operational check is useful over SSH, cron, or as a monitoring probe.

**Approach:** Report kernel, uptime, load, memory, filesystems, and failed systemd units using standard Linux tools.

**Engineering points:** predictable shell behaviour, minimal dependencies, readable output, and no destructive operations.

## Azure inventory

**Problem:** Azure resource sprawl makes inventory and review harder than it needs to be.

**Approach:** Use Azure CLI from PowerShell to collect resource name, type, resource group, and location into JSON.

**Engineering points:** authenticated access is external to the script, results are machine-readable, and subscription identifiers are never embedded in source control.
