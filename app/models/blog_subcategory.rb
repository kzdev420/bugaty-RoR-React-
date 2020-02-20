class BlogSubcategory < ApplicationRecord
  extend FriendlyId

  belongs_to :blog_category, required: true
  has_many :blog_posts, dependent: :destroy

  friendly_id :title, use: [:slugged, :finders]
end
