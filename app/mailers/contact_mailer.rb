class ContactMailer < ApplicationMailer
  # Sends message to admin when a contact form is submitted (keeping existing method name)
  def send_message(contact_message)
    @contact_message = contact_message

    mail(
      to: admin_email,
      subject: "New Contact Form Submission from #{contact_message.name}"
    )
  end

  # Sends notification to admin when a contact form is submitted
  def contact_notification(contact_message)
    @contact_message = contact_message

    mail(
      to: admin_email,
      subject: "New Contact Form Submission from #{contact_message.name}"
    )
  end

  # Sends confirmation to the user who submitted the contact form
  def contact_confirmation(contact_message, locale = I18n.default_locale)
    @contact_message = contact_message

    I18n.with_locale(locale) do
      mail(
        to: contact_message.email,
        subject: I18n.t("contact_mailer.confirmation.subject")
      )
    end
  end

  private

  def admin_email
    # You can set this in credentials or environment variables
    Rails.application.credentials.dig(:admin_email) || ENV["ADMIN_EMAIL"] || "info@gibugumi.com"
  end
end
