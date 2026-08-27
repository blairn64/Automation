"""Generate a reproducible synthetic 5,000-user manufacturing estate."""

from __future__ import annotations

import csv
import random
from pathlib import Path

SEED = 6402
USER_COUNT = 5000
SITES = ["NORTH", "CENTRAL", "SOUTH", "WEST"]
DEPARTMENTS = [
    "Engineering",
    "Production",
    "Operations",
    "Finance",
    "IT",
    "Quality",
    "Logistics",
    "Sales",
]
ROLES = [
    "Operator",
    "Engineer",
    "Supervisor",
    "Administrator",
    "Analyst",
    "Manager",
]

OUT = Path(__file__).with_name("users.csv")


def main() -> None:
    random.seed(SEED)
    OUT.parent.mkdir(parents=True, exist_ok=True)

    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["user_id", "display_name", "site", "department", "role", "enabled"],
        )
        writer.writeheader()

        for number in range(1, USER_COUNT + 1):
            site = random.choice(SITES)
            department = random.choice(DEPARTMENTS)
            role = random.choice(ROLES)
            writer.writerow(
                {
                    "user_id": f"USR-{number:05d}",
                    "display_name": f"Synthetic User {number:05d}",
                    "site": site,
                    "department": department,
                    "role": role,
                    "enabled": "true" if number % 97 else "false",
                }
            )

    print(f"Generated {USER_COUNT:,} synthetic users -> {OUT}")


if __name__ == "__main__":
    main()
