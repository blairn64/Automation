"""Small, disposable MongoDB example for the portfolio.

This demonstrates document-oriented storage and querying without using any
real client or production data.
"""

from os import getenv
from pymongo import MongoClient

MONGO_URI = getenv("MONGO_URI", "mongodb://localhost:27017")
client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=3000)
db = client["operations_lab"]
telemetry = db["telemetry"]

telemetry.insert_many(
    [
        {"asset": "LINE-01", "metric": "temperature", "value": 63.2},
        {"asset": "LINE-01", "metric": "pressure", "value": 4.8},
        {"asset": "LINE-02", "metric": "temperature", "value": 71.9},
    ]
)

for doc in telemetry.find({"metric": "temperature"}, {"_id": 0}).sort("value", -1):
    print(doc)
