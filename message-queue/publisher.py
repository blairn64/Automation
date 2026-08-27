#!/usr/bin/env python3
"""Publish a lab job to an AMQP-compatible broker."""

from __future__ import annotations

import json
import os
import sys
from urllib.parse import urlparse

import pika

QUEUE = os.getenv("AMQP_QUEUE", "automation.jobs")
AMQP_URL = os.getenv("AMQP_URL", "amqp://guest:guest@localhost:5672/%2F")


def main() -> int:
    parsed = urlparse(AMQP_URL)
    if parsed.scheme not in {"amqp", "amqps"}:
        raise ValueError("AMQP_URL must use amqp:// or amqps://")

    message = {"job": "health-check", "source": "portfolio-lab"}
    parameters = pika.URLParameters(AMQP_URL)
    connection = pika.BlockingConnection(parameters)
    try:
        channel = connection.channel()
        channel.queue_declare(queue=QUEUE, durable=True)
        channel.basic_publish(
            exchange="",
            routing_key=QUEUE,
            body=json.dumps(message).encode("utf-8"),
            properties=pika.BasicProperties(delivery_mode=2),
        )
        print(f"Published job to {QUEUE}")
    finally:
        connection.close()
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"Publish failed: {exc}", file=sys.stderr)
        raise SystemExit(1)
