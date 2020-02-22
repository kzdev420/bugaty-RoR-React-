class AddTitleToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :page_title, :string
  end
end
