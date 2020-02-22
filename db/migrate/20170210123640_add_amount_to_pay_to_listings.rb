class AddAmountToPayToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :amount_to_pay, :decimal, precision: 5, scale: 2
    add_column :listings, :amount_to_pay_currency, :string
  end
end
