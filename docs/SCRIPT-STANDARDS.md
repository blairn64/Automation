# Script Engineering Standards

## Baseline
Every new operational script should aim to provide:
- `[CmdletBinding()]` for advanced-function behaviour;
- parameter validation for predictable input;
- `Set-StrictMode -Version Latest` where compatible;
- `$ErrorActionPreference = 'Stop'` for deterministic failure handling;
- structured output suitable for automation;
- explicit dependency checks;
- actionable error messages;
- safe defaults;
- `SupportsShouldProcess` for state-changing actions;
- no embedded secrets, tenant identifiers or employer data.

## Output contract
Prefer objects for automation. Human-readable formatting belongs at the edge of the command, not inside reusable pipeline logic.

Recommended fields:
- operation
- target
- status
- timestamp (UTC)
- correlation/run ID when applicable
- error summary when failed

## Error handling
Do not swallow exceptions. Catch only where you can add useful context, retry safely, clean up, or return a documented status object.

## Safety model
State-changing scripts should:
1. validate prerequisites;
2. support `-WhatIf` where practical;
3. minimise irreversible actions;
4. fail before partial changes where possible;
5. leave enough output/evidence to explain what happened.

## Documentation minimum
Each script README/example should state:
- purpose;
- prerequisites;
- required permissions;
- example invocation;
- expected output;
- safe-use notes.

## Review checklist
- [ ] Inputs validated
- [ ] Errors actionable
- [ ] Secrets absent
- [ ] Output structured
- [ ] Dependencies checked
- [ ] State changes support safe preview/confirmation
- [ ] UTC timestamps used for evidence
- [ ] README/example updated
