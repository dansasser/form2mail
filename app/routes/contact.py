# contact.py

from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse
from app.models.contact import ContactForm
from app.services.email_service import send_email
import logging

router = APIRouter()

@router.post("/send-email/")
async def send_contact_email(contact_form: ContactForm, request: Request):
    try:
        # Log validated form data
        logging.info(f"Validated form data: {contact_form.dict()}")

        # Attempt to send the email
        await send_email(contact_form)

        # Return success response
        return {"status": "success", "message": "Message sent successfully"}

    except Exception as e:
        # Log the error
        logging.error(f"Error sending email: {str(e)}")

        # Return a JSON response with the error message
        return JSONResponse(
            status_code=200,
            content={
                "error": "Server Error",
                "message": "There was an issue sending your message. Please try again later."
            }
        )
