# Message Queue Architecture

## Components

```text
Producer
   |
   | JSON job
   v
AMQP broker
   |
   | durable queue
   v
Consumer
   |
   +--> processing
   +--> acknowledgement
   +--> failure handling
```

## Producer

`publisher.py` validates the broker URL, creates a durable queue and publishes a persistent message. Broker configuration is supplied through `AMQP_URL` and `AMQP_QUEUE`.

## Consumer

`consumer.py` uses `prefetch_count=1` so a worker receives a bounded amount of work. Successful jobs are acknowledged. Failed jobs are negatively acknowledged without requeue in this simple lab, making the failure policy explicit.

## Why AMQP

The queue boundary separates the request for work from the work itself. In a larger system this allows workers to scale independently and prevents slow jobs from blocking the caller.

## Local lab

The included Docker Compose definition provides a disposable RabbitMQ broker with a management interface. The default credentials are for local development only and must never be reused for a real deployment.

## Production considerations

A production implementation should use secret-managed credentials, TLS, least-privilege broker users, dead-letter exchanges, retry/backoff policy, idempotency keys, message tracing and durable operational metrics.
