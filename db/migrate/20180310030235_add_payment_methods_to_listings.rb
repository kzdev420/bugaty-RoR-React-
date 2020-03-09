class AddPaymentMethodsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :payment_methods, :string, array: true, default: []
  end
end
