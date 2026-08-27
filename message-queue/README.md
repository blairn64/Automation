# Message Queue Lab

A small RabbitMQ-compatible messaging example showing producer/consumer separation and asynchronous work processing.

## Architecture

```text
Client / API
     |
     v
  Publisher
     |
     v
 RabbitMQ-compatible broker
     |
     v
  Consumer
     |
     v
   Result / log
```

## Why it is here

This demonstrates practical messaging concepts: queues, acknowledgements, retry-friendly consumers and configuration through environment variables.

## Safety

The broker endpoint and credentials are supplied at runtime. No production endpoints, credentials or organisation-specific configuration belong in this repository.

## Run

The Python example uses `pika`. Point `AMQP_URL` at a local lab broker before running it.
