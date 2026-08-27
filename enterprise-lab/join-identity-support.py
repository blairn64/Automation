"""Join synthetic identities, sign-ins and support tickets into an operational view."""

from __future__ import annotations

import csv
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).parent
USERS = ROOT / "users.csv"
SIGNINS = ROOT / "signins.csv"
TICKETS = ROOT / "support-tickets.csv"
OUT = ROOT / "identity-support-summary.csv"


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def main() -> None:
    users = {row["user_id"]: row for row in read_csv(USERS)}
    signins = read_csv(SIGNINS)
    tickets = read_csv(TICKETS)

    failures = Counter(row["user_id"] for row in signins if row["result"] == "failure")
    ticket_counts = Counter(row.get("user_id", "") for row in tickets if row.get("user_id"))

    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["user_id", "site", "department", "role", "enabled", "signin_failures", "tickets"],
        )
        writer.writeheader()
        for user_id, user in users.items():
            writer.writerow(
                {
                    "user_id": user_id,
                    "site": user["site"],
                    "department": user["department"],
                    "role": user["role"],
                    "enabled": user["enabled"],
                    "signin_failures": failures[user_id],
                    "tickets": ticket_counts[user_id],
                }
            )

    print(f"Wrote operational identity/support view -> {OUT}")


if __name__ == "__main__":
    main()
