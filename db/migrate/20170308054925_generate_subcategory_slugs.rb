class GenerateSubcategorySlugs < ActiveRecord::Migration[5.0]
  def up
    Subcategory.all.each { |subcategory| subcategory.save! }
  end

  def down
  end
end
