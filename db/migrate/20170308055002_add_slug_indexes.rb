class AddSlugIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :slug, unique: true
    add_index :subcategories, :slug, unique: true
  end
end
