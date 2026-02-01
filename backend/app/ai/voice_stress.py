import torch
import numpy as np
import librosa
from transformers import pipeline

# Load once (VERY important for performance)
emotion_classifier = pipeline(
    task="audio-classification",
    model="microsoft/wavlm-base-plus",
    top_k=None
)


def analyze_voice(audio_path: str):
    # Load audio
    y, sr = librosa.load(audio_path, sr=16000)

    # Run emotion inference
    results = emotion_classifier(y)

    # Convert to dict
    emotions = {r["label"].lower(): r["score"] for r in results}

    # Stress score logic (THIS IS YOUR INTELLIGENCE)
    stress_score = (
        0.5 * emotions.get("fear", 0) +
        0.3 * emotions.get("angry", 0) +
        0.2 * emotions.get("sad", 0)
    )

    return {
        "emotions": emotions,
        "stress_score": round(float(stress_score), 3)
    }
