
from pydantic import BaseModel, EmailStr, Field

class ContactForm(BaseModel):
    name: str = Field(..., max_length=100)
    email: EmailStr
    phone: str = Field(..., max_length=20)  # Add a phone field
    subject: str = Field(..., max_length=150)
    message: str = Field(..., max_length=2000)
