class Recipe < ApplicationRecord
  validates :title, :description, presence: true
  # Virtual :image attribute
  include ImageUploader[:image]
end
