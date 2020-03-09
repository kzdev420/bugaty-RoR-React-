class Subcategory < ApplicationRecord
  has_many :listings
  belongs_to :category

  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
