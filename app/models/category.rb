class Category < ApplicationRecord
  has_many :listings, dependent: :destroy
  has_many :subcategories, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
