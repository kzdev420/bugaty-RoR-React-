class AddFieldsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :title, :string
    add_column :categories, :keywords, :string
    add_column :categories, :description, :text
  end
end
