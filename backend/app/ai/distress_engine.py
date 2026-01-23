
def is_user_in_distress(motion_value=None, voice_features=None):
    """
    AI distress fusion logic (PoC-safe).
    Normalizes input so model never crashes.
    """

    # -----------------------------
    # Normalize voice features
    # -----------------------------
    if voice_features is None:
        voice_features = [0] * 40

    if len(voice_features) < 40:
        voice_features = voice_features + [0] * (40 - len(voice_features))

    if len(voice_features) > 40:
        voice_features = voice_features[:40]

    # -----------------------------
    # Simple fusion logic for demo
    # -----------------------------
    motion_alert = motion_value is not None and motion_value > 20
    voice_alert = sum(voice_features) > 5

    return motion_alert or voice_alert
