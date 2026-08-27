from __future__ import annotations

import json
import random
import time
from datetime import datetime, timezone

random.seed(7401)

ASSETS = ["LINE-01", "LINE-02", "LINE-03", "LINE-04"]


def sample(asset: str) -> dict:
    temperature = round(random.uniform(55, 85), 2)
    pressure = round(random.uniform(3.5, 6.5), 2)
    state = random.choice(["running", "running", "running", "idle", "fault"])
    return {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "asset": asset,
        "protocol": "S7-lab",
        "machine_state": state,
        "temperature_c": temperature,
        "pressure_bar": pressure,
        "quality": "good" if state != "fault" and temperature < 80 else "warning",
    }


for _ in range(5):
    for asset in ASSETS:
        print(json.dumps(sample(asset), sort_keys=True))
    time.sleep(0.2)
