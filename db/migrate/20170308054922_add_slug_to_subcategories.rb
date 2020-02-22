class AddSlugToSubcategories < ActiveRecord::Migration[5.0]
  def change
    add_column :subcategories, :slug, :string
  end
end
