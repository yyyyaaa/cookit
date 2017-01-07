class Recipe < ApplicationRecord
  has_many :ingredients, inverse_of: :recipe
  has_many :instructions, inverse_of: :recipe
  belongs_to :user
  # Virtual :image attribute
  include ImageUploader[:image]

  validates :title, :description, presence: true
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :instructions,
                                reject_if: :all_blank,
                                allow_destroy: true

end
