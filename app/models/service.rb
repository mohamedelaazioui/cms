class Service < ApplicationRecord
  has_one_attached :icon

  validates :title, presence: true
  validates :description, presence: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :locale, presence: true, inclusion: { in: %w[en ja] }

  scope :by_locale, ->(locale) { where(locale: locale) }
  default_scope { order(position: :asc) }
end
