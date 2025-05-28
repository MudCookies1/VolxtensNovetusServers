from fastapi import FastAPI, Request
from typing import List, Dict
from fastapi.responses import JSONResponse
import json, base64

app = FastAPI()

# Global memory store for players
latest_players: List[Dict[str, str]] = []

@app.get("/server/info/{data}")
async def receive_player_list(data: str):
    global latest_players
    try:
        # Decode base64 data, and parse JSON manually
        players_data = json.loads(base64.b64decode(data))
        # Validate each player is a dict with expected keys
        latest_players = []
        for p in players_data:
            if isinstance(p, dict) and "PlayerName" in p and "PlayerId" in p:
                latest_players.append({
                    "PlayerName": str(p["PlayerName"]),
                    "PlayerId": str(p["PlayerId"])
                })
            else:
                return JSONResponse(content={"error": "Invalid player structure"}, status_code=400)
        return {"status": "Player list received", "playerCount": len(latest_players)}
    except Exception as e:
        return JSONResponse(content={"error": "Invalid data", "details": str(e)}, status_code=400)

@app.get("/info")
async def get_player_info():
    return {
        "playerCount": len(latest_players),
        "players": latest_players
    }
