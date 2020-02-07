class AddSerialNumberToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :serial_number, :integer
  end
end
