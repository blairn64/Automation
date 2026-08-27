"""Generate synthetic service-desk volume for a multi-site enterprise lab."""

from __future__ import annotations

import argparse
import csv
from collections import Counter
from pathlib import Path
from random import Random

CATEGORIES = [
    "identity",
    "m365",
    "network",
    "application",
    "server",
    "security",
    "endpoint",
    "factory-telemetry",
]
SEVERITY = ["P4", "P3", "P2", "P1"]


def generate(days: int, seed: int = 42) -> list[dict[str, object]]:
    rng = Random(seed)
    rows = []
    for day in range(days):
        # Synthetic daily load representing a large enterprise support estate.
        volume = rng.randint(105, 180)
        for ticket in range(volume):
            rows.append(
                {
                    "day": day + 1,
                    "ticket_id": f"LAB-{day + 1:03d}-{ticket + 1:04d}",
                    "category": rng.choice(CATEGORIES),
                    "priority": rng.choices(SEVERITY, weights=[55, 32, 11, 2])[0],
                    "automatable": rng.random() < 0.38,
                }
            )
    return rows


def write(rows: list[dict[str, object]], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate synthetic enterprise support volume")
    parser.add_argument("--days", type=int, default=30)
    parser.add_argument("--output", type=Path, default=Path("support-volume.csv"))
    args = parser.parse_args()
    if not 1 <= args.days <= 365:
        raise SystemExit("--days must be between 1 and 365")

    rows = generate(args.days)
    write(rows, args.output)
    counts = Counter(row["category"] for row in rows)
    print(f"Generated {len(rows):,} synthetic tickets over {args.days} days")
    for category, count in counts.most_common():
        print(f"  {category}: {count:,}")


if __name__ == "__main__":
    main()
