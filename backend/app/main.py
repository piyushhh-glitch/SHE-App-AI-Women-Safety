from fastapi import FastAPI
from pydantic import BaseModel
from dotenv import load_dotenv
from app.services.sos_service import process_sos

load_dotenv()

app = FastAPI(title="SHE App Backend")

class SOSRequest(BaseModel):
    user_id: str
    location: str

@app.get("/")
def root():
    return {"status": "SHE backend running"}

@app.post("/sos")
def sos(payload: SOSRequest):
    return process_sos(payload.dict())
