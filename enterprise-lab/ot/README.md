# OT / PLC Telemetry Lab

Isolated simulator for PLC-connected production assets and sensor/scale telemetry.

`s7-telemetry-simulator.py` emits structured machine-state events representing an S7-style boundary. It does not connect to a real PLC.

## Fault scenarios

- Asset stops reporting
- Sensor value exceeds expected range
- Machine enters fault state
- Telemetry timestamp becomes stale
- Network path to the consumer is unavailable

## Support workflow

Validate source -> validate network path -> inspect ingestion -> inspect queue/consumer -> compare source and processed values -> correlate with application and monitoring timestamps.