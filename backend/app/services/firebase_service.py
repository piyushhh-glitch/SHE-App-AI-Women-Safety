import firebase_admin
from firebase_admin import credentials, firestore
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(__file__)))
cred_path = os.getenv(
    "FIREBASE_CREDENTIALS",
    os.path.join(BASE_DIR, "firebase_key.json")
)

if not firebase_admin._apps:
    cred = credentials.Certificate(cred_path)
    firebase_admin.initialize_app(cred)

db = firestore.client()
