from datetime import datetime
from ..services.firebase_service import db

def save_live_location(user_id: str, lat: float, lng: float):
    data = {
        "user_id": user_id,
        "latitude": lat,
        "longitude": lng,
        "timestamp": datetime.utcnow()
    }

    # Store inside a collection called "sos_locations"
    db.collection("sos_locations").add(data)

    return {"status": "location_updated"}
