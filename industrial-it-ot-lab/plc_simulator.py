"""Safe PLC-style tag simulator for the industrial IT/OT lab.

This does not connect to a real PLC. It produces a deterministic machine-state
model that can be consumed by the same downstream telemetry pipeline.
"""

from __future__ import annotations

import argparse
import json
from datetime import datetime, timezone
from random import Random


def build_event(rng: Random, asset: str, site: str) -> dict[str, object]:
    temperature = round(rng.normalvariate(68.0, 2.5), 1)
    weight = round(max(0.0, rng.normalvariate(19.5, 0.6)), 2)
    count = rng.randint(140, 240)

    status = "critical" if temperature >= 76 else "warning" if temperature >= 72 else "ok"
    return {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "site": site,
        "asset": asset,
        "source": "plc",
        "metric": "machine_temperature",
        "value": temperature,
        "unit": "C",
        "status": status,
        "machine": {"production_count": count, "weight": weight, "weight_unit": "kg"},
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate synthetic PLC-style telemetry")
    parser.add_argument("--asset", default="LINE-01")
    parser.add_argument("--site", default="SITE-A")
    args = parser.parse_args()

    event = build_event(Random(42), args.asset, args.site)
    print(json.dumps(event, separators=(",", ":")))


if __name__ == "__main__":
    main()
