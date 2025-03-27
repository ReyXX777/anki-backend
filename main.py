from fastapi import FastAPI, HTTPException
import requests

app = FastAPI()

ANKI_CONNECT_URL = "http://localhost:8765"

@app.post("/add-card/")
async def add_card(deck_name: str, front: str, back: str):
    payload = {
        "action": "addNote",
        "version": 6,
        "params": {
            "note": {
                "deckName": deck_name,
                "modelName": "Basic",
                "fields": {"Front": front, "Back": back},
                "tags": ["api"],
                "options": {"allowDuplicate": False}
            }
        }
    }
    response = requests.post(ANKI_CONNECT_URL, json=payload)
    if response.status_code == 200:
        return response.json()
    else:
        raise HTTPException(status_code=500, detail="Failed to add card")

@app.get("/get-decks/")
async def get_decks():
    payload = {"action": "deckNames", "version": 6}
    response = requests.post(ANKI_CONNECT_URL, json=payload)
    if response.status_code == 200:
        return response.json()
    else:
        raise HTTPException(status_code=500, detail="Failed to fetch decks")
