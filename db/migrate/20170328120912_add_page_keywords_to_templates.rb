class AddPageKeywordsToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :page_keywords, :string
  end
end
