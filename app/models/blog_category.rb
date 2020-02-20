class BlogCategory < ApplicationRecord
  has_many :blog_subcategories, dependent: :destroy
  extend FriendlyId

  friendly_id :title, use: [:slugged, :finders]
end
