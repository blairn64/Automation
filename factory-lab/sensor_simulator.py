#!/usr/bin/env python3
"""Generate synthetic factory telemetry and publish it over AMQP."""

from __future__ import annotations

import json
import os
import random
import time
from datetime import datetime, timezone
from urllib.parse import urlparse

import pika

AMQP_URL = os.getenv("AMQP_URL", "amqp://guest:guest@localhost:5672/%2F")
QUEUE = os.getenv("AMQP_QUEUE", "factory.telemetry")
INTERVAL = float(os.getenv("TELEMETRY_INTERVAL", "2"))


def build_event() -> dict[str, object]:
    load = round(random.uniform(45, 95), 1)
    temperature = round(55 + (load * 0.2) + random.uniform(-3, 3), 1)
    state = "RUNNING" if random.random() > 0.08 else "IDLE"
    return {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "site": random.choice(["SITE-A", "SITE-B"]),
        "line": random.choice(["LINE-01", "LINE-02"]),
        "machine": random.choice(["MACHINE-01", "MACHINE-02", "MACHINE-03"]),
        "temperature_c": temperature,
        "load_pct": load,
        "units_per_minute": random.randint(28, 55) if state == "RUNNING" else 0,
        "state": state,
    }


def main() -> None:
    parsed = urlparse(AMQP_URL)
    if parsed.scheme not in {"amqp", "amqps"}:
        raise ValueError("AMQP_URL must use amqp:// or amqps://")

    connection = pika.BlockingConnection(pika.URLParameters(AMQP_URL))
    try:
        channel = connection.channel()
        channel.queue_declare(queue=QUEUE, durable=True)
        while True:
            event = build_event()
            channel.basic_publish(
                exchange="",
                routing_key=QUEUE,
                body=json.dumps(event).encode("utf-8"),
                properties=pika.BasicProperties(content_type="application/json", delivery_mode=2),
            )
            print(json.dumps(event))
            time.sleep(INTERVAL)
    finally:
        connection.close()


if __name__ == "__main__":
    main()
