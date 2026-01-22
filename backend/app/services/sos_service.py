from app.services.firebase_service import db
from datetime import datetime

def process_sos(data):
    sos_data = {
        "user_id": data.get("user_id"),
        "location": data.get("location"),
        "timestamp": datetime.utcnow().isoformat(),
        "status": "SOS_TRIGGERED"
    }

    db.collection("sos_alerts").add(sos_data)

    return {
        "alert": "SOS Triggered",
        "status": "HELP_ON_THE_WAY",
        "data": sos_data
    }
