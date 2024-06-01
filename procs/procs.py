import imaplib
import email
from email.header import decode_header
import re

# Configuration
IMAP_SERVER = 'imap.example.com'  # Replace with your IMAP server
EMAIL_ACCOUNT = 'your-email@example.com'
EMAIL_PASSWORD = 'your-password'

def connect_to_email():
    # Connect to the server
    mail = imaplib.IMAP4_SSL(IMAP_SERVER)
    
    # Login to the account
    mail.login(EMAIL_ACCOUNT, EMAIL_PASSWORD)
    return mail

def fetch_unread_email(mail):
    # Select the mailbox you want to check
    mail.select("inbox")
    
    # Search for unread emails
    status, messages = mail.search(None, '(UNSEEN)')
    
    # Get the list of email IDs
    email_ids = messages[0].split()
    return email_ids

def parse_email_subject(subject):
    # Decode the email subject
    decoded_subject, encoding = decode_header(subject)[0]
    if isinstance(decoded_subject, bytes):
        if encoding:
            decoded_subject = decoded_subject.decode(encoding)
        else:
            decoded_subject = decoded_subject.decode('utf-8')
    return decoded_subject

def extract_first_word(subject):
    # Extract the first word from the subject
    match = re.match(r"\w+", subject)
    if match:
        return match.group(0)
    return ""

def process_email(mail, email_id):
    # Fetch the email by ID
    status, msg_data = mail.fetch(email_id, "(RFC822)")
    
    # Get the email content
    raw_email = msg_data[0][1]
    msg = email.message_from_bytes(raw_email)
    
    # Parse the email subject
    subject = parse_email_subject(msg["subject"])
    first_word = extract_first_word(subject)
    
    # Get the email body
    desc = ""
    if msg.is_multipart():
        for part in msg.walk():
            content_type = part.get_content_type()
            content_disposition = str(part.get("Content-Disposition"))
            if "attachment" not in content_disposition:
                if content_type == "text/plain":
                    desc = part.get_payload(decode=True).decode()
                    break
    else:
        desc = msg.get_payload(decode=True).decode()

    return first_word, desc

def main():
    # Connect to the email account
    mail = connect_to_email()
    
    # Fetch unread emails
    email_ids = fetch_unread_email(mail)
    
    if not email_ids:
        print("No unread emails found.")
        return
    
    # Process the first unread email
    first_email_id = email_ids[0]
    first_word, desc = process_email(mail, first_email_id)
    
    print("First word from subject:", first_word)
    print("Description:", desc)
    
    # Mark the email as read
    mail.store(first_email_id, '+FLAGS', '\Seen')
    
    # Logout
    mail.logout()

if __name__ == "__main__":
    main()

