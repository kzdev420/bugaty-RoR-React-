class AddTemplateFileds < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :how_it_works_text, :text
    add_column :templates, :trust_and_safety_text, :text
  end
end
