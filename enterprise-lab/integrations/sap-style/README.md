# SAP-style enterprise integration

A vendor-neutral integration exercise representing the kind of boundary commonly found between manufacturing applications and an ERP platform.

## Demonstrates

- Production-order contract validation
- Idempotency keys
- Retry with bounded backoff
- Explicit failure handling
- Separation between factory systems and external business systems

The implementation does not reproduce or expose any proprietary ERP interface. It is a clean-room portfolio example.

Run:

```bash
python sap-integration.py
```
