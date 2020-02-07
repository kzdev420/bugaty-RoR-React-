class AddMetaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :title, :string
    add_column :users, :keywords, :string
  end
end
