"""Generate synthetic authentication telemetry for the 5,000-user lab."""

from __future__ import annotations

import csv
import random
from datetime import datetime, timedelta, timezone
from pathlib import Path

SEED = 6403
EVENT_COUNT = 15000
SITES = ["NORTH", "CENTRAL", "SOUTH", "WEST"]
COUNTRIES = ["CA", "GB", "US", "DE"]
RESULTS = ["success"] * 13 + ["failure"] * 2
OUT = Path(__file__).with_name("signins.csv")


def main() -> None:
    random.seed(SEED)
    start = datetime(2026, 8, 1, tzinfo=timezone.utc)
    OUT.parent.mkdir(parents=True, exist_ok=True)

    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["timestamp", "user_id", "site", "country", "result", "client"],
        )
        writer.writeheader()
        for index in range(EVENT_COUNT):
            timestamp = start + timedelta(minutes=random.randint(0, 60 * 24 * 14))
            user_id = f"USR-{random.randint(1, 5000):05d}"
            writer.writerow(
                {
                    "timestamp": timestamp.isoformat().replace("+00:00", "Z"),
                    "user_id": user_id,
                    "site": random.choice(SITES),
                    "country": random.choice(COUNTRIES),
                    "result": random.choice(RESULTS),
                    "client": random.choice(["Windows", "Linux", "Web", "Mobile"]),
                }
            )

    print(f"Generated {EVENT_COUNT:,} synthetic sign-in events -> {OUT}")


if __name__ == "__main__":
    main()
