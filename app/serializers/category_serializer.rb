class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :slug, :subcategories

  def subcategories
    object.subcategories.in_groups_of(5)
  end
end
