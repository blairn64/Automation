from __future__ import annotations

from flask import Flask, jsonify, request

app = Flask(__name__)

ORDERS = {
    "SO-10001": {"material": "MAT-001", "quantity": 120, "status": "released"},
    "SO-10002": {"material": "MAT-002", "quantity": 80, "status": "released"},
}

@app.get("/api/orders/<order_id>")
def get_order(order_id: str):
    order = ORDERS.get(order_id)
    if not order:
        return jsonify({"error": "order_not_found"}), 404
    return jsonify({"order_id": order_id, **order})

@app.post("/api/production-confirmation")
def confirm_production():
    payload = request.get_json(silent=True) or {}
    required = {"order_id", "quantity", "timestamp"}
    missing = sorted(required - payload.keys())
    if missing:
        return jsonify({"error": "missing_fields", "fields": missing}), 400
    return jsonify({"accepted": True, "reference": f"CONF-{payload['order_id']}", "received": payload}), 202

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8090, debug=False)
