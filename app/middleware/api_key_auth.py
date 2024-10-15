# /app/middleware/api_key_auth.py

from fastapi import Request, HTTPException
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

API_KEY = os.getenv("API_KEY") or "your-secure-api-key"  # Replace with your actual API key

async def api_key_auth_middleware(request: Request, call_next):
    # Allow OPTIONS requests to pass through
    if request.method == "OPTIONS":
        return await call_next(request)

    api_key = request.headers.get("x-api-key")
    if api_key != API_KEY:
        raise HTTPException(status_code=401, detail="Unauthorized")

    response = await call_next(request)
    return response
