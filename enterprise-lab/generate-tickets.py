"""Generate synthetic service-desk demand for a 5,000-user enterprise lab."""

from __future__ import annotations

import csv
import random
from datetime import datetime, timedelta, timezone
from pathlib import Path

SEED = 6404
TICKET_COUNT = 2500
CATEGORIES = [
    "Identity",
    "Microsoft 365",
    "Network",
    "Factory Application",
    "SQL",
    "Server",
    "Security",
    "Endpoint",
    "Telemetry",
]
PRIORITIES = ["P4"] * 9 + ["P3"] * 5 + ["P2"] * 2 + ["P1"]
SITES = ["NORTH", "CENTRAL", "SOUTH", "WEST"]
STATUSES = ["Resolved"] * 7 + ["In Progress"] * 2 + ["Escalated"]
OUT = Path(__file__).with_name("support-tickets.csv")


def main() -> None:
    random.seed(SEED)
    start = datetime(2026, 8, 1, tzinfo=timezone.utc)
    OUT.parent.mkdir(parents=True, exist_ok=True)

    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=[
                "ticket_id",
                "created_at",
                "site",
                "category",
                "priority",
                "status",
                "escalation_level",
            ],
        )
        writer.writeheader()
        for number in range(1, TICKET_COUNT + 1):
            priority = random.choice(PRIORITIES)
            escalation = 0 if priority == "P4" else random.choice([0, 1, 2])
            writer.writerow(
                {
                    "ticket_id": f"INC-{number:05d}",
                    "created_at": (
                        start + timedelta(minutes=random.randint(0, 60 * 24 * 14))
                    ).isoformat().replace("+00:00", "Z"),
                    "site": random.choice(SITES),
                    "category": random.choice(CATEGORIES),
                    "priority": priority,
                    "status": random.choice(STATUSES),
                    "escalation_level": escalation,
                }
            )

    print(f"Generated {TICKET_COUNT:,} synthetic tickets -> {OUT}")


if __name__ == "__main__":
    main()
