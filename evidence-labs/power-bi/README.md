# Power BI / Operational Reporting Lab

This folder contains a small synthetic dataset designed for a Power BI operational KPI report.

## Suggested report

Create cards for:

- Total throughput
- Total downtime minutes
- Number of warning/critical records
- Throughput by site
- Downtime by asset
- Metric trend over time

## Modelling notes

The CSV is intentionally flat so it can be imported directly. In a larger solution, split site/asset dimensions from the event fact table and keep timestamps in UTC.

The dataset is fictional and exists only to demonstrate report-ready data preparation and KPI thinking. No employer data is included.
