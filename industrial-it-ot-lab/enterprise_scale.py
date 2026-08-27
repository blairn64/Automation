"""Generate a synthetic enterprise estate at thousands-of-users scale.

This is portfolio data only. It creates no real accounts and makes no calls to
Microsoft 365, Entra ID, Active Directory or any corporate environment.
"""

from __future__ import annotations

import argparse
import csv
import random
from pathlib import Path

SITES = ["SITE-A", "SITE-B", "SITE-C", "SITE-D", "HQ"]
DEPARTMENTS = ["Production", "Engineering", "Finance", "Sales", "IT", "HR", "Quality"]
ROLES = ["User", "Supervisor", "Engineer", "Administrator", "ServiceDesk"]


def generate_users(count: int, seed: int = 42) -> list[dict[str, object]]:
    rng = random.Random(seed)
    rows: list[dict[str, object]] = []
    for index in range(1, count + 1):
        site = rng.choice(SITES)
        rows.append(
            {
                "user_id": f"U{index:05d}",
                "site": site,
                "department": rng.choice(DEPARTMENTS),
                "role": rng.choices(ROLES, weights=[82, 8, 5, 1, 4])[0],
                "enabled": rng.random() > 0.02,
                "mfa_registered": rng.random() > 0.08,
                "cloud_enabled": rng.random() > 0.03,
            }
        )
    return rows


def write_csv(rows: list[dict[str, object]], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate synthetic multi-site user estate")
    parser.add_argument("--users", type=int, default=5000)
    parser.add_argument("--output", type=Path, default=Path("synthetic-users.csv"))
    args = parser.parse_args()

    if args.users < 1 or args.users > 100_000:
        raise SystemExit("--users must be between 1 and 100000")

    rows = generate_users(args.users)
    write_csv(rows, args.output)
    print(f"Generated {len(rows):,} synthetic users across {len(SITES)} sites: {args.output}")


if __name__ == "__main__":
    main()
