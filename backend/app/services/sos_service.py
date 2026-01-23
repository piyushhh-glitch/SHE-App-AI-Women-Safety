from datetime import datetime
from app.services.firebase_service import db
from app.ai.distress_engine import is_user_in_distress


def process_sos(user_id, location, motion=None, voice_features=None):
    try:
        # -----------------------------
        # 1️⃣ AI DISTRESS CHECK
        # -----------------------------
        distress = is_user_in_distress(
            motion_value=motion,
            voice_features=voice_features
        )

        if not distress:
            return {
                "status": "no_distress_detected"
            }

        # -----------------------------
        # 2️⃣ SAVE SOS TO FIRESTORE
        # -----------------------------
        sos_data = {
            "user_id": user_id,
            "location": location,
            "status": "SOS_TRIGGERED",
            "timestamp": datetime.utcnow().isoformat()
        }

        db.collection("sos_alerts").add(sos_data)

        return {
            "status": "sos_triggered",
            "message": "Help is on the way"
        }

    except Exception as e:
        # 🔴 THIS IS WHAT WAS MISSING
        print("🔥 SOS ERROR:", str(e))

        return {
            "status": "error",
            "message": str(e)
        }
