import requests
import os

HF_API_URL = "https://api-inference.huggingface.co/models/meta-llama/Meta-Llama-3.1-8B-Instruct"

HF_TOKEN = os.getenv("HF_TOKEN")

headers = {
    "Authorization": f"Bearer {HF_TOKEN}",
    "Content-Type": "application/json"
}

SYSTEM_PROMPT = """
You are SHE Smart Bot, a calm and supportive assistant for women's safety.
Rules:
- Be empathetic and calm
- Never give legal or medical advice
- Never blame the user
- Never guarantee safety
- Do not command, only suggest
- Keep responses under 3 sentences
"""

def generate_reply(user_message: str, intent: str) -> str:
    prompt = f"""
{SYSTEM_PROMPT}

Detected intent: {intent}
User message: "{user_message}"

Respond appropriately.
"""

    payload = {
        "inputs": prompt,
        "parameters": {
            "max_new_tokens": 120,
            "temperature": 0.4,
            "top_p": 0.9
        }
    }

    response = requests.post(HF_API_URL, headers=headers, json=payload, timeout=30)
    response.raise_for_status()

    data = response.json()
    return data[0]["generated_text"].split("Respond appropriately.")[-1].strip()
