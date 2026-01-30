
from dotenv import load_dotenv
from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime

# 🔹 Import services
from .services.sos_service import process_sos
from .services.location_service import save_live_location

app = FastAPI(
    title="SHE App Backend",
    description="AI-powered Women Safety System",
    version="1.0.0"
)

# -----------------------------
# MODELS
# -----------------------------

class SOSRequest(BaseModel):
    user_id: str
    location: str
    motion: float | None = None
    voice_features: list | None = None


class LocationUpdate(BaseModel):
    user_id: str
    lat: float
    lng: float


# -----------------------------
# ROOT
# -----------------------------

@app.get("/")
def root():
    return {
        "status": "SHE backend running",
        "timestamp": datetime.utcnow()
    }


# -----------------------------
# SOS ENDPOINT
# -----------------------------

@app.post("/sos")
def trigger_sos(data: SOSRequest):
    """
    Trigger SOS event.
    Called from Flutter when user long-presses SOS button.
    """
    return process_sos(
        user_id=data.user_id,
        location=data.location,
        motion=data.motion,
        voice_features=data.voice_features
    )


# -----------------------------
# LIVE LOCATION ENDPOINT
# -----------------------------

@app.post("/location")
def update_location(data: LocationUpdate):
    """
    Receive live GPS coordinates during active SOS.
    Called every few seconds from Flutter.
    """
    return save_live_location(
        user_id=data.user_id,
        lat=data.lat,
        lng=data.lng
    )

