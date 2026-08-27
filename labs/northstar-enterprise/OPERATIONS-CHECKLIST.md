# Northstar Enterprise Lab — Operations Checklist

## Daily
- [ ] DC01/DC02 reachable
- [ ] AD replication healthy
- [ ] DNS core records resolve
- [ ] file shares reachable
- [ ] print queues processing
- [ ] application health endpoint responds
- [ ] synthetic database check succeeds
- [ ] RabbitMQ reachable
- [ ] queue depth reviewed
- [ ] telemetry ingestion current
- [ ] active alerts reviewed
- [ ] capacity thresholds reviewed

## Weekly
- [ ] review alert noise and false positives
- [ ] review capacity trends
- [ ] review failed authentication patterns
- [ ] validate backup/maintenance evidence
- [ ] run one controlled recovery validation
- [ ] review documentation drift

## Monthly
- [ ] run an incident scenario end-to-end
- [ ] validate build documentation
- [ ] review service dependency map
- [ ] review firewall policy assumptions
- [ ] review privileged access model
- [ ] archive synthetic incident evidence

## Scenario readiness
Before demonstrating Northstar:
- [ ] environment health baseline captured
- [ ] monitoring view available
- [ ] scenario chosen
- [ ] fault injection is reversible
- [ ] recovery procedure reviewed
- [ ] evidence location prepared
- [ ] post-incident validation criteria defined
