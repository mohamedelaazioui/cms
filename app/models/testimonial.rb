class Testimonial < ApplicationRecord
  has_one_attached :avatar

  validates :name, presence: true
  validates :quote, presence: true
  validates :locale, presence: true, inclusion: { in: %w[en ja] }

  scope :by_locale, ->(locale) { where(locale: locale) }
end
