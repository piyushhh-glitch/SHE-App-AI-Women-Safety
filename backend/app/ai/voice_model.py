import torch
import torch.nn as nn

class VoiceDistressModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc = nn.Linear(40, 2)  # MFCC-like features

    def forward(self, x):
        return self.fc(x)

def detect_voice_distress(features):
    """
    PoC-level inference
    """
    model = VoiceDistressModel()
    with torch.no_grad():
        x = torch.tensor(features, dtype=torch.float32)
        output = model(x)
        prediction = torch.argmax(output).item()
    return prediction == 1
