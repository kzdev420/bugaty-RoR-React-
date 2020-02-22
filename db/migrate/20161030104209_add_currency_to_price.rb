class AddCurrencyToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :currency, :string
  end
end
