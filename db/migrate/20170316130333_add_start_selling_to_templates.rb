class AddStartSellingToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :start_selling, :text
  end
end
