# Northstar Elastic Investigation Queries

Use these as portable investigation patterns; adapt index names and field mappings to the local stack.

## Ingestion freshness
```text
@timestamp < now-5m
```

## Authentication failures by source
```text
activity:PasswordFailure | stats count by host.name, department
```

## Queue backlog investigation
```text
event.category:telemetry AND severity:(warning OR error)
```

## Application outage timeline
```text
host.name:APP01 AND (event.category:application OR service.name:iis)
```

## Correlation-first investigation
```text
correlation_id:<scenario-or-workload-id>
```

## Operational rule
Start with time, scope and correlation. Expand from the affected service to its dependencies rather than searching every log source blindly.
