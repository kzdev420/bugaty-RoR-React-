class AddFieldsToSubcategories < ActiveRecord::Migration[5.0]
  def change
    add_column :subcategories, :title, :string
    add_column :subcategories, :keywords, :string
    add_column :subcategories, :description, :text
  end
end
