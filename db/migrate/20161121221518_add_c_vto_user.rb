class AddCVtoUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :cv, :string
  end
end
