class AddStaticPages < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :terms, :text
    add_column :templates, :privacy, :text
  end
end
