class AddSaleFieldsToSearch < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :sale_min, :decimal
    add_column :searches, :sale_max, :decimal
  end
end
