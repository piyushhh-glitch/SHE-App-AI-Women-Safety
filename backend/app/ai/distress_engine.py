from app.ai.motion_model import detect_motion_distress
from app.ai.voice_model import detect_voice_distress

def is_user_in_distress(motion_value: float, voice_features) -> bool:
    motion_alert = detect_motion_distress(motion_value)
    voice_alert = detect_voice_distress(voice_features)

    # PoC fusion logic
    return motion_alert or voice_alert
