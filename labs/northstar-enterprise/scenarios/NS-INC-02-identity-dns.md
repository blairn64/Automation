# NS-INC-02 — Identity and DNS Failure

## Objective

Demonstrate structured troubleshooting across Active Directory, DNS and Windows client dependencies.

## Lab topology

- `DC01` — primary AD DS/DNS role
- `DC02` — secondary AD DS/DNS role
- synthetic client fleet across HQ and plant networks
- segmented management, server and user networks

## Controlled fault

Introduce a lab-only DNS or identity dependency failure using the scenario tooling. The scenario should simulate a service or configuration fault without changing external DNS or real credentials.

## Expected symptoms

- hostname resolution failures or incorrect responses;
- authentication-dependent application errors;
- client logon or resource access symptoms;
- relevant Windows event log entries.

## Investigation

1. Identify affected scope: one client, one VLAN, one site or broad environment.
2. Validate IP addressing, gateway and DNS server assignment.
3. Test name resolution for domain controllers and dependent services.
4. Check AD DS and DNS service state on `DC01` and `DC02`.
5. Validate replication and service discovery where applicable.
6. Correct the synthetic fault and repeat the original failing test.

## Evidence

- client network configuration;
- DNS test output;
- relevant event records;
- domain controller service state;
- replication/health output where available;
- before/after validation.

## RCA

Record the difference between the user-visible symptom and the underlying dependency failure. This scenario is specifically intended to demonstrate layered troubleshooting rather than jumping directly to a domain-controller assumption.
