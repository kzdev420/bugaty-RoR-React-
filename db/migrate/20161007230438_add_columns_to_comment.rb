class AddColumnsToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :title, :string
    add_column :comments, :type, :integer
  end
end
