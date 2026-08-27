"""Summarise synthetic service-desk workload for operational review."""
from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).parent
INPUT = ROOT.parent / "enterprise-lab" / "support-tickets.csv"


def main() -> None:
    with INPUT.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))

    by_category = Counter(row["category"] for row in rows)
    by_priority = Counter(row["priority"] for row in rows)
    escalated = sum(row["status"] == "Escalated" for row in rows)

    print(f"Tickets: {len(rows):,}")
    print(f"Escalated: {escalated:,}")
    print("By priority:")
    for key, count in sorted(by_priority.items()):
        print(f"  {key}: {count:,}")
    print("By category:")
    for key, count in by_category.most_common():
        print(f"  {key}: {count:,}")


if __name__ == "__main__":
    main()
