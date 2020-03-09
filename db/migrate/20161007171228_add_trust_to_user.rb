class AddTrustToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nomoderation, :boolean
  end
end
