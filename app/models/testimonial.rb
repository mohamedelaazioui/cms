class Testimonial < ApplicationRecord
  has_one_attached :avatar

  validates :name, presence: true
  validates :quote, presence: true
end
