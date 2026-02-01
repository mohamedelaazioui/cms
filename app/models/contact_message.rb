class ContactMessage < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 2 }
  
  # Custom validation to ensure message is not just whitespace
  validate :message_not_blank
  
  private
  
  def message_not_blank
    if message.present? && message.strip.blank?
      errors.add(:message, "cannot be blank")
    end
  end
end
