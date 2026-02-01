def get_response(intent: str):
    responses = {
        "FEAR": {
            "reply": "I’m here with you. You’re not alone. Take a slow breath with me.",
            "suggest_sos": False
        },
        "FOLLOWED": {
            "reply": "That sounds worrying. Try moving toward a well-lit or crowded place. I can help alert someone if you want.",
            "suggest_sos": True
        },
        "PANIC": {
            "reply": "Let’s slow down together. Focus on your breathing. Inhale slowly… exhale. I’m here.",
            "suggest_sos": False
        },
        "APP_HELP": {
            "reply": "The SOS button alerts your trusted contacts with your live location instantly.",
            "suggest_sos": False
        },
        "SOS_CONFIRM": {
            "reply": "If you feel unsafe, I can help trigger SOS right now. Just tell me.",
            "suggest_sos": True
        },
        "UNKNOWN": {
            "reply": "I’m here to help. Can you tell me a little more about what’s happening?",
            "suggest_sos": False
        }
    }

    return responses.get(intent, responses["UNKNOWN"])
