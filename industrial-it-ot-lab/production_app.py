"""Flask application-tier simulator for the factory lab."""

from __future__ import annotations

from datetime import datetime, timezone
from flask import Flask, jsonify, request

app = Flask(__name__)

LATEST = {
    "site": "SITE-A",
    "asset": "LINE-01",
    "production_count": 184,
    "temperature_c": 68.4,
    "weight_kg": 19.7,
    "status": "ok",
    "updated_at": datetime.now(timezone.utc).isoformat(),
}


@app.get("/health")
def health():
    return jsonify({"status": "ok", "service": "production-app-sim"})


@app.get("/api/v1/machine-state")
def machine_state():
    return jsonify(LATEST)


@app.post("/api/v1/telemetry")
def receive_telemetry():
    payload = request.get_json(silent=True)
    required = {"site", "asset", "metric", "value"}
    if not isinstance(payload, dict) or not required.issubset(payload):
        return jsonify({"error": "invalid telemetry payload"}), 400

    LATEST.update(
        {
            "site": payload["site"],
            "asset": payload["asset"],
            "last_metric": payload["metric"],
            "last_value": payload["value"],
            "updated_at": datetime.now(timezone.utc).isoformat(),
        }
    )
    return jsonify({"accepted": True, "state": LATEST}), 202


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8088)
