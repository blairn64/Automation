"""Synthetic Northstar RabbitMQ telemetry consumer.
Consumes JSON telemetry and writes NDJSON suitable for a lab Elastic bulk pipeline.
No production credentials or endpoints are included.
"""
import json
import os
from datetime import datetime, timezone
from pathlib import Path

import pika

AMQP_URL = os.getenv('NORTHSTAR_AMQP_URL', 'amqp://guest:guest@localhost:5672/%2F')
QUEUE = os.getenv('NORTHSTAR_TELEMETRY_QUEUE', 'northstar.telemetry')
OUT = Path(os.getenv('NORTHSTAR_TELEMETRY_OUT', './telemetry-events.ndjson'))


def callback(ch, method, properties, body):
    event = json.loads(body.decode('utf-8'))
    event.setdefault('@timestamp', datetime.now(timezone.utc).isoformat())
    event.setdefault('event', {})
    event['event'].setdefault('dataset', 'northstar.ot.telemetry')
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open('a', encoding='utf-8') as handle:
        handle.write(json.dumps(event) + '\n')
    ch.basic_ack(delivery_tag=method.delivery_tag)


params = pika.URLParameters(AMQP_URL)
connection = pika.BlockingConnection(params)
channel = connection.channel()
channel.queue_declare(queue=QUEUE, durable=True)
channel.basic_qos(prefetch_count=25)
channel.basic_consume(queue=QUEUE, on_message_callback=callback)
print(f'Northstar telemetry consumer listening on {QUEUE}')
channel.start_consuming()
