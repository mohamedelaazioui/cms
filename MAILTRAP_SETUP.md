# Mailtrap Setup Instructions

## Overview
Mailtrap is configured for email testing in the development environment. All emails sent from the application will be captured by Mailtrap instead of being delivered to real recipients.

## Setup Steps

### 1. Create Mailtrap Account
1. Go to [https://mailtrap.io](https://mailtrap.io)
2. Sign up for a free account
3. Navigate to your inbox

### 2. Get SMTP Credentials
From your Mailtrap inbox, you'll find:
- **Host**: `sandbox.smtp.mailtrap.io`
- **Port**: `2525`
- **Username**: (your unique username)
- **Password**: (your unique password)

### 3. Add Credentials to Rails

Run the following command to edit encrypted credentials:
```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Add your Mailtrap credentials:
```yaml
mailtrap:
  username: your_mailtrap_username
  password: your_mailtrap_password
```

Save and close the editor.

### 4. Restart Rails Server
```bash
bin/dev
```

## Testing Email Delivery

### Using Rails Console
```ruby
# Open Rails console
bin/rails console

# Send a test email (assuming you have a mailer set up)
# Example with a contact form:
ContactMailer.contact_notification(
  name: "Test User",
  email: "test@example.com",
  message: "This is a test message"
).deliver_now

# Or use Action Mailer's test helpers
ApplicationMailer.default(to: 'test@example.com').mail(
  subject: 'Test Email',
  body: 'This is a test email from GIBU GUMI'
).deliver_now
```

### Check Mailtrap Inbox
1. Go to your Mailtrap inbox at [https://mailtrap.io](https://mailtrap.io)
2. You should see the test email appear
3. Click on it to view the email content, HTML/text versions, and headers

## Configuration Details

### Development Environment
- **File**: `config/environments/development.rb`
- **Delivery Method**: SMTP via Mailtrap
- **Raise Errors**: Enabled (so you'll see if emails fail to send)

### Application Mailer
- **File**: `app/mailers/application_mailer.rb`
- **Default From**: `noreply@gibugumi.com`

## Production Considerations

For production, you'll want to:
1. Use a real email service (SendGrid, Mailgun, AWS SES, etc.)
2. Configure SMTP settings in `config/environments/production.rb`
3. Store production credentials securely in Rails credentials

Example production configuration:
```ruby
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: 587,
  user_name: Rails.application.credentials.dig(:sendgrid, :username),
  password: Rails.application.credentials.dig(:sendgrid, :api_key),
  authentication: :plain,
  enable_starttls_auto: true
}
```

## Troubleshooting

### Error: "Missing credentials"
- Make sure you've added credentials using `bin/rails credentials:edit`
- Verify the YAML structure matches exactly (use 2 spaces for indentation)

### Error: "Connection refused"
- Check your internet connection
- Verify Mailtrap service is not down at [status.mailtrap.io](https://status.mailtrap.io)

### Emails not appearing in Mailtrap
- Verify credentials are correct
- Check Rails logs for error messages: `tail -f log/development.log`
- Ensure `raise_delivery_errors` is set to `true` in development

## Resources

- [Mailtrap Documentation](https://mailtrap.io/docs/)
- [Action Mailer Rails Guide](https://guides.rubyonrails.org/action_mailer_basics.html)
- [Rails Credentials Guide](https://guides.rubyonrails.org/security.html#custom-credentials)
