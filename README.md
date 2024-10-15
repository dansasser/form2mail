# Contact Form Emailer

**Contact Form Emailer** is a customizable tool designed to handle website contact form submissions via email using **FastAPI** and **SMTP integration**. It offers secure and efficient contact form processing, automatically sending emails upon form submission, and supports API key authentication for added security. This application is ideal for developers who need a reliable backend service for contact forms with customizable email sending capabilities.

## About GOROMBO

This project is brought to you by **GOROMBO**, a premier provider of **digital storefront solutions** and **custom software** development. We specialize in creating powerful, flexible systems for businesses, including secure contact forms, POS systems, and AI-driven storefront management tools.

Visit us at **[GOROMBO.com](https://gorombo.com)** to learn more about our products and services.

Stay connected with us:

- [GOROMBO on Facebook](https://www.facebook.com/GoromboDevelopment)

## Key Features of Contact Form Emailer

- **FastAPI Contact Form Processing**: Built with FastAPI for quick and efficient handling of contact form submissions.
- **SMTP Email Delivery Integration**: Sends emails using your SMTP server, allowing full control over email delivery.
- **Custom Reply-To Functionality**: Sets the submitter's email address as the "Reply-To", ensuring replies go directly to the user.
- **API Key Authentication**: Secures the contact form submission endpoint to prevent unauthorized access.
- **Customizable Email Sender and Recipient**: Easily adjust the sender's name, email address, and recipient details through environment variables.
- **Error Handling**: Provides detailed JSON responses for both successful submissions and error conditions.
- **Easy Deployment**: Simple installation and setup process, suitable for both local development and production environments.

## Project Structure and Organization

This FastAPI contact form emailer is structured to ensure easy configuration and rapid deployment for developers building websites that need a customizable and secure contact form email service.

```bash
.
├── app
│   ├── models
│   │   └── contact.py          # Defines the Pydantic model for validating contact form inputs
│   ├── routes
│   │   └── contact.py          # Handles the contact form submissions via FastAPI's POST request
│   ├── services
│   │   └── email_service.py    # Sends emails using the configured SMTP server via aiosmtplib
│   ├── middleware
│   │   └── api_key_auth.py     # Middleware to protect the endpoint with API key authentication
│   └── config
│       └── settings.py         # Configuration file for application settings (e.g., allowed CORS origins)
├── installer.sh                # Bash script for setup and starting the application
├── requirements.txt            # Python dependencies for the project
├── venv/                       # Python virtual environment directory
├── .env                        # Environment variables for SMTP and API key settings
└── main.py                     # FastAPI application entry point
```

## Installation and Setup

Follow these steps to get the **Contact Form Emailer** running on your system.

### Prerequisites

To run this contact form processing tool efficiently, you'll need:

- **Python 3.8+**
- **pip** (Python package installer)
- **virtualenv** (recommended but optional)
- **Bash shell** (for running the installer script)
- **uvicorn** and **FastAPI** (will be installed via `requirements.txt`)

### Installation Steps

1. **Clone the Repository**

   Clone the repository to your local machine and navigate into the project directory.

   ```bash
   git clone https://github.com/yourusername/contact-form-emailer.git
   cd contact-form-emailer
   ```

2. **Configure Environment Variables**

   Before running the installer, ensure that you have a `.env` file with the necessary configurations. If you don't have one, you can create it by renaming the `.env.example` file:

   ```bash
   mv .env.example .env
   ```

   Edit the `.env` file to match your SMTP server configuration:

   ```env
   # SMTP Configuration
   SMTP_SERVER=mail.privateemail.com
   SMTP_PORT=465
   EMAIL_SENDER=contact@gorombo.com
   EMAIL_RECEIVER=your-email@example.com
   EMAIL_PASSWORD=your-password

   # API Key for Authentication
   API_KEY=your-api-key
   ```

3. **Run the Installation Script**

   Use the `installer.sh` script to set up the project. This script configures a virtual environment, installs the required dependencies, and starts the FastAPI server to process contact form submissions.

   ```bash
   ./installer.sh
   ```

   **Note**: The installer script not only sets up the environment but also starts the application. It will activate the virtual environment and run the server automatically.

4. **Alternative Manual Setup (Optional)**

   If you prefer to set up and start the application manually:

   - **Create a Virtual Environment**

     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```

   - **Install Dependencies**

     ```bash
     pip install -r requirements.txt
     ```

   - **Run the FastAPI Application**

     ```bash
     uvicorn main:app --host 0.0.0.0 --port 3081
     ```

## Usage

### Sending a Test Request

Once the application is running, you can send a POST request to the `/send-email/` endpoint to test the contact form emailer.

#### Example API Request Using cURL

```bash
curl -X POST http://localhost:3081/send-email/ \
  -H 'Content-Type: application/json' \
  -H 'x-api-key: your-api-key' \
  -d '{
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "+1234567890",
    "subject": "Inquiry",
    "message": "This is a test message."
  }'
```

#### Example API Request Using JavaScript Fetch

```javascript
const contactFormData = {
  name: 'John Doe',
  email: 'john.doe@example.com',
  phone: '+1234567890',
  subject: 'Contact Us',
  message: 'Hello, I would like more information about your services.'
}

fetch('http://localhost:3081/send-email/', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'x-api-key': 'your-api-key'
  },
  body: JSON.stringify(contactFormData)
})
  .then((response) => response.json())
  .then((data) => console.log('Success:', data))
  .catch((error) => console.error('Error:', error))
```

#### Example API Request Using Postman

- **Method**: POST
- **URL**: `http://localhost:3081/send-email/`
- **Headers**:
  - `Content-Type`: `application/json`
  - `x-api-key`: `your-api-key`
- **Body**: Raw JSON

  ```json
  {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "+1234567890",
    "subject": "Inquiry",
    "message": "This is a test message."
  }
  ```

### Response Format

- **Success Response (Status Code: 200)**

  ```json
  {
    "status": "success",
    "message": "Message sent successfully"
  }
  ```

- **Error Response (Status Code: 200 with Error Content)**

  ```json
  {
    "error": "Server Error",
    "message": "There was an issue sending your message. Please try again later."
  }
  ```

  _Note_: Even in the case of errors, the application returns a `200 OK` status code with error details in the response body.

## Benefits of Using Contact Form Emailer

1. **FastAPI Contact Form Processing**: Leverage FastAPI for efficient and high-performance handling of contact form submissions.
2. **SMTP Integration for Email Delivery**: Use your own SMTP server settings for complete control over email delivery.
3. **Secure Contact Form Submissions**: Protect your API endpoint with API key authentication to prevent unauthorized access.
4. **Customizable and Extensible**: Easily adjust settings and extend functionalities to fit your specific needs.
5. **Seamless Deployment**: Simple setup allows for quick deployment in both development and production environments.

## Frequently Asked Questions (FAQ)

### Q: How do I change the email sender name displayed in the emails?

A: You can customize the sender name in the `email_service.py` file by modifying the `From` header:

```python
email_message["From"] = f"Your Custom Name <{EMAIL_SENDER}>"
```

### Q: How do I enable SSL/TLS for SMTP?

A: Ensure that you set `use_tls=True` and `start_tls=False` in the `send_email` function if your SMTP server requires SSL/TLS (common for port 465).

### Q: Can I add additional fields to the contact form?

A: Yes, you can modify the `ContactForm` model in `app/models/contact.py` to include additional fields, and adjust the `email_service.py` and `contact.py` accordingly.

## Contributing to Contact Form Emailer

If you're interested in contributing to **Contact Form Emailer**, feel free to submit issues or pull requests. All contributions are welcome, and you can help improve this tool for the entire community.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
