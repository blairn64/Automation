# Northstar Enterprise Lab — Monitoring Implementation Matrix

| Monitoring objective | Elastic/Kibana | Grafana-style | Zabbix-style | ManageEngine-style |
|---|---|---|---|---|
| Host availability | heartbeat/event view | status panel | host ping/agent | availability monitor |
| Windows services | Winlogbeat/event query | service status | service trigger | service monitor |
| DNS | DNS events/query | DNS status | DNS check | DNS monitor |
| IIS | logs/HTTP events | HTTP panel | web scenario | URL monitor |
| Capacity | metric/event trend | time-series panels | thresholds/triggers | performance monitor |
| RabbitMQ | indexed queue metrics | queue panels | queue checks | application monitor |
| Alerting | ElastAlert 2 | alert rules | triggers/actions | thresholds/escalations |

## Operational intent
The portfolio does not claim all four products are simultaneously installed in one production stack. The matrix demonstrates how the same operational signals can be represented across tools the operator has experience with.

## Recommended implementation order
1. Establish core health signals.
2. Establish telemetry freshness.
3. Add dependency checks.
4. Add thresholds only after baseline data exists.
5. Tune noisy alerts.
6. Capture evidence from real lab runs.
