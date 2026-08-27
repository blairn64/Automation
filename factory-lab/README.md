# Factory Telemetry Lab

A sanitized, self-contained demonstration of a manufacturing telemetry pipeline.

This is **not** a copy of any employer system. It models the engineering shape of a factory environment using synthetic sensor data so the repository can demonstrate IT/OT concepts safely.

## What it demonstrates

- Synthetic production and sensor telemetry
- AMQP message queues
- Python producers and consumers
- Structured JSON events
- SQL persistence
- Operational monitoring patterns
- Clear separation between plant-side data production and IT-side processing

## Architecture

```text
+-------------------+
| Sensor simulator  |
| temperature/load  |
| production state  |
+---------+---------+
          |
          | AMQP
          v
+-------------------+
| RabbitMQ          |
| telemetry queue   |
+---------+---------+
          |
          v
+-------------------+
| Processing worker |
| validation        |
| anomaly checks    |
+---------+---------+
          |
          v
+-------------------+
| SQL / reporting   |
+-------------------+
```

The simulator deliberately behaves like a system at the edge of production rather than connecting to a real PLC or factory subnet.

## Safety boundary

The lab contains no industrial control addresses, PLC credentials, proprietary protocols, production hostnames or workplace data. It must remain a simulation. Do not connect these examples to operational technology that you are not explicitly authorised to test.

## Run

The broker can be started locally with the included Docker Compose file. Python dependencies are listed in `requirements.txt`.

```bash
docker compose up -d
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python sensor_simulator.py
```

In another shell:

```bash
python worker.py
```

## Event example

```json
{
  "site": "SITE-A",
  "line": "LINE-01",
  "machine": "MACHINE-01",
  "temperature_c": 71.4,
  "load_pct": 83.2,
  "units_per_minute": 42,
  "state": "RUNNING"
}
```

All values are synthetic.

## Portfolio relevance

This project is designed to show how infrastructure, application support, messaging, monitoring and data systems can fit together around a production-style workload without exposing real operational technology.
