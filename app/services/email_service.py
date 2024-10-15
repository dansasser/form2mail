import os
import logging
from email.message import EmailMessage
from dotenv import load_dotenv
from aiosmtplib import send
from fastapi import HTTPException
from app.models.contact import ContactForm

# Load environment variables
load_dotenv()

SMTP_SERVER = os.getenv("SMTP_SERVER")
SMTP_PORT = int(os.getenv("SMTP_PORT"))
EMAIL_SENDER = os.getenv("EMAIL_SENDER")
EMAIL_RECEIVER = os.getenv("EMAIL_RECEIVER")
EMAIL_PASSWORD = os.getenv("EMAIL_PASSWORD")

async def send_email(contact_form: ContactForm):
    """Sends an email with the contact form information"""

    email_message = EmailMessage()
    email_message["From"] = f"Contact Form <{EMAIL_SENDER}>"
    email_message["To"] = EMAIL_RECEIVER  # You can change this to a different recipient if needed
    email_message["Reply-To"] = contact_form.email
    email_message["Subject"] = f"Contact form: {contact_form.subject}"

    email_body = (
        "Email sent from Website Contact Form\n"
        f"Contact Name: {contact_form.name}\n"
        f"Contact Phone: {contact_form.phone}\n"
        f"Contact Email: {contact_form.email}\n\n"
        f"Message:\n{contact_form.message}"
    )

    email_message.set_content(email_body)

    try:
        # Send the email using aiosmtplib with SSL (for port 465)
        await send(
            email_message,
            hostname=SMTP_SERVER,
            port=SMTP_PORT,
            username=EMAIL_SENDER,
            password=EMAIL_PASSWORD,
            start_tls=False,  # Disable STARTTLS
            use_tls=True,     # Enable SSL/TLS for port 465
        )
    except Exception as e:
        # Log the error (for debugging)
        logging.error(f"Error sending email: {str(e)}")

        # Raise a 500 HTTP exception with a custom JSON response
        raise HTTPException(
            status_code=500,
            detail={
                "error": "Server Error",
                "message": "There was an issue sending your message. Please try again later."
            }
        )
