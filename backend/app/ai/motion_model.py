def detect_motion_distress(acceleration: float) -> bool:
    """
    Simple PoC logic:
    High sudden acceleration = possible struggle/fall
    """
    THRESHOLD = 15.0  # tuned for demo
    return acceleration > THRESHOLD
