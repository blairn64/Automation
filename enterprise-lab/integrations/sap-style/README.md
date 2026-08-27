# SAP-Style ERP Integration Lab

A vendor-neutral simulator for the integration boundary between manufacturing applications and an ERP platform.

## Demonstrates

- Production-order contract validation
- Idempotency and duplicate handling
- Bounded retry/error handling
- Explicit downstream failure handling
- Separation between factory systems and external business systems
- Reconciliation of source and accepted transactions

## Runnable component

`sap-simulator.py` exposes a small Flask API for order lookup and production confirmation.

This is a clean-room portfolio implementation. It does not reproduce or expose any proprietary ERP interface or real business data.
