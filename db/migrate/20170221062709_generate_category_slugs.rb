class GenerateCategorySlugs < ActiveRecord::Migration[5.0]
  def up
    Category.all.each { |category| category.save! }
  end

  def down
  end
end
