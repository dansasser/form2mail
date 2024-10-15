from dotenv import load_dotenv
import os

load_dotenv()

# Allowed origins for CORS
ALLOWED_ORIGINS = [
    "http://localhost:4321",
    "https://chrisandsonsllc.com",
    "https://chris.gorombo.com"
    # Add more trusted origins as needed
]
