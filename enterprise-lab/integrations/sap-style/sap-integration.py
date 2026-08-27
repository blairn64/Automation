"""Synthetic SAP-style integration boundary for the enterprise lab.

This is a vendor-neutral contract example, not a replica of any proprietary SAP
interface. It demonstrates validation, retries, idempotency and clear errors.
"""
from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
import json
import time


@dataclass(frozen=True)
class ProductionOrder:
    order_id: str
    site: str
    material: str
    quantity: int


def event_key(order: ProductionOrder) -> str:
    payload = f"{order.order_id}|{order.site}|{order.material}|{order.quantity}"
    return sha256(payload.encode("utf-8")).hexdigest()


def validate(order: ProductionOrder) -> None:
    if not order.order_id or not order.site or not order.material:
        raise ValueError("order_id, site and material are required")
    if order.quantity <= 0:
        raise ValueError("quantity must be positive")


def send_to_external_system(order: ProductionOrder, attempt: int) -> dict[str, object]:
    validate(order)
    return {
        "accepted": True,
        "attempt": attempt,
        "idempotency_key": event_key(order),
        "payload": {
            "order_id": order.order_id,
            "site": order.site,
            "material": order.material,
            "quantity": order.quantity,
        },
    }


def publish_with_retry(order: ProductionOrder, attempts: int = 3) -> dict[str, object]:
    last_error: Exception | None = None
    for attempt in range(1, attempts + 1):
        try:
            return send_to_external_system(order, attempt)
        except Exception as exc:  # pragma: no cover - demonstration boundary
            last_error = exc
            time.sleep(0.05 * attempt)
    raise RuntimeError(f"external integration failed: {last_error}")


if __name__ == "__main__":
    result = publish_with_retry(
        ProductionOrder(order_id="PO-10001", site="NORTH", material="WIDGET-A", quantity=120)
    )
    print(json.dumps(result, indent=2))
