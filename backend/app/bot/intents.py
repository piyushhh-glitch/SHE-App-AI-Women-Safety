def detect_intent(message: str) -> str:
    text = message.lower()

    if any(word in text for word in ["follow", "behind me", "someone is following"]):
        return "FOLLOWED"

    if any(word in text for word in ["panic", "breath", "scared", "terrified"]):
        return "PANIC"

    if any(word in text for word in ["unsafe", "afraid", "fear"]):
        return "FEAR"

    if any(word in text for word in ["help", "how to", "what is", "how does"]):
        return "APP_HELP"

    if any(word in text for word in ["sos", "alert", "call help"]):
        return "SOS_CONFIRM"

    return "UNKNOWN"
