class AddPayableToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :payable, :boolean, default: true
  end
end
