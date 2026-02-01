from .intents import detect_intent
from .responses import get_response
from .llm_client import generate_reply

def handle_message(message: str):
    intent = detect_intent(message)

    rule_response = get_response(intent)

    # Use LLM only for wording
    try:
        reply = generate_reply(message, intent)
    except Exception:
        reply = rule_response["reply"]  # fallback (VERY important)

    return {
        "reply": reply,
        "suggest_sos": rule_response["suggest_sos"],
        "intent": intent
    }
