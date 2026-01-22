from fastapi import FastAPI
from app.services.sos_service import process_sos

app = FastAPI(title="SHE App Backend")

@app.get("/")
def root():
    return {"status": "SHE backend running"}

@app.post("/sos")
def sos(payload: dict):
    return process_sos(payload)
