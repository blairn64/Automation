#!/usr/bin/env python3
"""Consume jobs from an AMQP-compatible broker."""

from __future__ import annotations

import json
import os
import sys
from typing import Any

import pika

QUEUE = os.getenv("AMQP_QUEUE", "automation.jobs")
AMQP_URL = os.getenv("AMQP_URL", "amqp://guest:guest@localhost:5672/%2F")


def handle_job(body: bytes) -> None:
    payload: Any = json.loads(body.decode("utf-8"))
    if not isinstance(payload, dict):
        raise ValueError("Job payload must be a JSON object")
    print(f"Processing job: {payload.get('job', 'unknown')}")


def main() -> int:
    parameters = pika.URLParameters(AMQP_URL)
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()
    channel.queue_declare(queue=QUEUE, durable=True)
    channel.basic_qos(prefetch_count=1)

    def callback(ch: Any, method: Any, properties: Any, body: bytes) -> None:
        try:
            handle_job(body)
        except Exception as exc:
            print(f"Job failed: {exc}", file=sys.stderr)
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)
            return
        ch.basic_ack(delivery_tag=method.delivery_tag)

    channel.basic_consume(queue=QUEUE, on_message_callback=callback)
    print(f"Waiting for jobs on {QUEUE}. Press Ctrl+C to stop.")
    channel.start_consuming()
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        raise SystemExit(0)
