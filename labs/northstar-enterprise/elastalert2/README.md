# ElastAlert 2 Detection Layer

ElastAlert 2 is used here as a rule-based detection and alerting component over synthetic Elasticsearch data. It supports pattern-based rules and multiple alert outputs, and the official project recommends container deployment for straightforward operation. citeturn0search0turn0search2turn0search4

## Lab flow

```mermaid
flowchart LR
    E[Events] --> ES[Elasticsearch]
    ES --> EA[ElastAlert 2]
    EA --> R[Rule match]
    R --> A[Alert]
    A --> I[Incident scenario]
    I --> RCA[Investigation / RCA]
```

## Included rules

- `identity/privileged-group-change.yaml`
- `infrastructure/rabbitmq-backlog.yaml`

## Rule design principles

- Start with a clear operational question.
- Use synthetic, repeatable event data.
- Keep thresholds visible in the rule.
- Use `realert` to avoid alert storms.
- Test rules against known data before treating them as useful.
- A detection without an investigation path is unfinished.

## Running with Docker

Mount a configuration file and rule directory into the official ElastAlert 2 container image. The exact image tag should be pinned for repeatable lab builds rather than relying on an unreviewed moving `latest` tag. The official documentation describes both Docker and direct package operation and provides rule testing guidance. citeturn0search0turn0search1turn0search6

This repository intentionally does not include real webhook URLs, SMTP credentials, API keys or production alert destinations.
