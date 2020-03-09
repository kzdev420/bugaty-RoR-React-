class BlogCategorySerializer < ApplicationSerializer
  attributes :id, :title, :slug, :blog_subcategories
end
