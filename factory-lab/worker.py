#!/usr/bin/env python3
"""Consume and validate synthetic factory telemetry."""

from __future__ import annotations

import json
import os
import sys
from typing import Any

import pika

AMQP_URL = os.getenv("AMQP_URL", "amqp://guest:guest@localhost:5672/%2F")
QUEUE = os.getenv("AMQP_QUEUE", "factory.telemetry")


def validate(event: dict[str, Any]) -> list[str]:
    errors: list[str] = []
    required = {"timestamp", "site", "line", "machine", "temperature_c", "load_pct", "units_per_minute", "state"}
    errors.extend(f"missing:{key}" for key in sorted(required - event.keys()))

    if "temperature_c" in event and not isinstance(event["temperature_c"], (int, float)):
        errors.append("temperature_c must be numeric")
    if "load_pct" in event and not 0 <= float(event["load_pct"]) <= 100:
        errors.append("load_pct must be between 0 and 100")
    if "state" in event and event["state"] not in {"RUNNING", "IDLE"}:
        errors.append("state is not recognised")
    return errors


def handle(body: bytes) -> None:
    event = json.loads(body.decode("utf-8"))
    if not isinstance(event, dict):
        raise ValueError("Telemetry payload must be a JSON object")

    errors = validate(event)
    if errors:
        print(json.dumps({"status": "rejected", "errors": errors, "event": event}))
        return

    alert = float(event["temperature_c"]) >= 80 or float(event["load_pct"]) >= 95
    result = {"status": "accepted", "alert": alert, "site": event["site"], "machine": event["machine"]}
    print(json.dumps(result))


def main() -> int:
    connection = pika.BlockingConnection(pika.URLParameters(AMQP_URL))
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE, durable=True)
    channel.basic_qos(prefetch_count=1)

    def callback(ch: Any, method: Any, properties: Any, body: bytes) -> None:
        try:
            handle(body)
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as exc:
            print(f"Telemetry processing failed: {exc}", file=sys.stderr)
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    channel.basic_consume(queue=QUEUE, on_message_callback=callback)
    print(f"Consuming {QUEUE}")
    channel.start_consuming()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
