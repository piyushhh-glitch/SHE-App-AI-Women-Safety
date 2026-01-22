def process_sos(data):
    return {
        "alert": "SOS Triggered",
        "user": data.get("user_id"),
        "location": data.get("location"),
        "status": "HELP_ON_THE_WAY"
    }
