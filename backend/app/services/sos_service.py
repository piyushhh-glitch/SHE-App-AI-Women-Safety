from app.services.firebase_service import db
from datetime import datetime
from app.ai.distress_engine import is_user_in_distress


def process_sos(data):
    distress = is_user_in_distress(
        motion_value=data.get("motion", 0),
        voice_features=data.get("voice_features", [0]*40)
    )

    if not distress:
        return {"status": "No distress detected"}

    sos_data = {
        "user_id": data.get("user_id"),
        "location": data.get("location"),
        "status": "SOS_TRIGGERED"
    }

    db.collection("sos_alerts").add(sos_data)

    return {
        "alert": "AUTO SOS Triggered",
        "data": sos_data
    }

