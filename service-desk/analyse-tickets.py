from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).parent
INPUT = ROOT.parent / "enterprise-lab" / "support-tickets.csv"
OUTPUT = ROOT / "ticket-summary.csv"


def main() -> None:
    with INPUT.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))

    by_category = Counter(row["category"] for row in rows)
    by_priority = Counter(row["priority"] for row in rows)
    escalated = sum(row["status"] == "Escalated" for row in rows)

    summary = [
        {"metric": "total_tickets", "value": len(rows)},
        {"metric": "escalated_tickets", "value": escalated},
    ]
    summary.extend({"metric": f"category:{k}", "value": v} for k, v in sorted(by_category.items()))
    summary.extend({"metric": f"priority:{k}", "value": v} for k, v in sorted(by_priority.items()))

    with OUTPUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["metric", "value"])
        writer.writeheader()
        writer.writerows(summary)

    print(f"Tickets: {len(rows):,}")
    print(f"Escalated: {escalated:,}")
    print(f"Summary written to {OUTPUT}")


if __name__ == "__main__":
    main()
