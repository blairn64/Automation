import json

from worker import handle, validate


def valid_event():
    return {
        "timestamp": "2026-01-01T00:00:00+00:00",
        "site": "SITE-A",
        "line": "LINE-01",
        "machine": "MACHINE-01",
        "temperature_c": 70.0,
        "load_pct": 80.0,
        "units_per_minute": 40,
        "state": "RUNNING",
    }


def test_validate_accepts_valid_event():
    assert validate(valid_event()) == []


def test_validate_rejects_out_of_range_load():
    event = valid_event()
    event["load_pct"] = 120
    assert "load_pct must be between 0 and 100" in validate(event)


def test_handle_reports_alert_for_high_temperature(capsys):
    event = valid_event()
    event["temperature_c"] = 85
    handle(json.dumps(event).encode("utf-8"))
    output = json.loads(capsys.readouterr().out)
    assert output["status"] == "accepted"
    assert output["alert"] is True


def test_handle_rejects_unknown_state(capsys):
    event = valid_event()
    event["state"] = "FAULT"
    handle(json.dumps(event).encode("utf-8"))
    output = json.loads(capsys.readouterr().out)
    assert output["status"] == "rejected"
    assert "state is not recognised" in output["errors"]
