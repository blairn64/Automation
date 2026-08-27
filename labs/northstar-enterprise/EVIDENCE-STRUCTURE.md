# Northstar Enterprise Lab — Evidence Structure

## Principle
Evidence is generated from lab execution. Documentation may define expected evidence, but it must not pretend that a screenshot, metric or incident log exists before it is collected.

## Repository structure

```text
evidence/
├── YYYY-MM-DD/
│   ├── baseline/
│   ├── scenarios/
│   │   ├── NS-INC-01/
│   │   ├── NS-INC-02/
│   │   ├── NS-INC-03/
│   │   ├── NS-INC-04/
│   │   └── NS-INC-05/
│   └── dashboards/
└── README.md
```

## Required scenario evidence
- baseline health output;
- detection timestamp;
- investigation commands/checks;
- relevant synthetic logs;
- recovery action;
- validation output;
- RCA.

## Naming convention

```text
YYYYMMDD-HHMMSS_<scenario>_<stage>_<description>
```

Example:

```text
20260827-143200_NS-INC-04_detection_http-health.json
```

## Sanitisation
Before publishing evidence:
- remove secrets and tokens;
- remove real usernames and email addresses;
- remove private IPs if they identify a real environment;
- remove employer names or proprietary identifiers;
- confirm all screenshots and logs are from the synthetic lab.
