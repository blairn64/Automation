import json
import os
from datetime import datetime, timezone
from pathlib import Path
import pika

RABBITMQ_HOST = os.getenv("RABBITMQ_HOST", "rabbitmq")
QUEUE = os.getenv("RABBITMQ_QUEUE", "northstar.telemetry")
OUTPUT = Path(os.getenv("TELEMETRY_OUTPUT", "/data/telemetry.ndjson"))

OUTPUT.parent.mkdir(parents=True, exist_ok=True)

params = pika.ConnectionParameters(host=RABBITMQ_HOST, heartbeat=30)
connection = pika.BlockingConnection(params)
channel = connection.channel()
channel.queue_declare(queue=QUEUE, durable=True)

print(f"Northstar telemetry consumer connected to {RABBITMQ_HOST}; queue={QUEUE}")

def callback(ch, method, properties, body):
    try:
        event = json.loads(body.decode("utf-8"))
    except json.JSONDecodeError:
        event = {"message": body.decode("utf-8", errors="replace")}
    event.setdefault("@timestamp", datetime.now(timezone.utc).isoformat())
    event.setdefault("environment", "northstar-lab")
    with OUTPUT.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(event, separators=(",", ":")) + "\n")
    ch.basic_ack(delivery_tag=method.delivery_tag)

channel.basic_qos(prefetch_count=50)
channel.basic_consume(queue=QUEUE, on_message_callback=callback)
channel.start_consuming()
