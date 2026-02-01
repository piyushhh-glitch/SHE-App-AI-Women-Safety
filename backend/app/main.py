from dotenv import load_dotenv
from fastapi import FastAPI, UploadFile, File, Body
from pydantic import BaseModel
from datetime import datetime
import tempfile

# =============================
# LOAD ENV
# =============================
load_dotenv()

# =============================
# APP (ONLY ONE)
# =============================
app = FastAPI(
    title="SHE App Backend",
    description="AI-powered Women Safety System",
    version="1.0.0"
)

# =============================
# IMPORT SERVICES
# =============================
from app.services.sos_service import process_sos
from app.services.location_service import save_live_location
from app.ai.voice_stress import analyze_voice
from app.bot.she_bot import handle_message

# =============================
# MODELS
# =============================

class SOSRequest(BaseModel):
    user_id: str
    location: str
    motion: float | None = None
    voice_features: list | None = None


class LocationUpdate(BaseModel):
    user_id: str
    lat: float
    lng: float


class BotRequest(BaseModel):
    message: str


# =============================
# ROOT
# =============================

@app.get("/")
def root():
    return {
        "status": "SHE backend running",
        "timestamp": datetime.utcnow()
    }

# =============================
# SOS ENDPOINT
# =============================

@app.post("/sos")
def trigger_sos(data: SOSRequest):
    """
    Trigger SOS event.
    Called from Flutter (button OR bot).
    """
    print("🚨 SOS RECEIVED:", data.dict())

    return process_sos(
        user_id=data.user_id,
        location=data.location,
        motion=data.motion,
        voice_features=data.voice_features
    )

# =============================
# LIVE LOCATION
# =============================

@app.post("/location")
def update_location(data: LocationUpdate):
    """
    Receive live GPS coordinates during active SOS.
    """
    return save_live_location(
        user_id=data.user_id,
        lat=data.lat,
        lng=data.lng
    )

# =============================
# VOICE STRESS ANALYSIS
# =============================

@app.post("/analyze-voice")
async def analyze_voice_api(file: UploadFile = File(...)):
    with tempfile.NamedTemporaryFile(delete=False, suffix=".wav") as tmp:
        tmp.write(await file.read())
        tmp_path = tmp.name

    result = analyze_voice(tmp_path)

    return {
        "stress_detected": result["stress_score"] > 0.8,
        "stress_score": result["stress_score"],
        "emotions": result["emotions"]
    }

# =============================
# SHE SMART BOT
# =============================

@app.post("/she-bot/chat")
def she_bot_chat(req: BotRequest):
    return handle_message(req.message)
