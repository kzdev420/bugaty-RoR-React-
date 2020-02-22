class ChangeUserDefaults < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :receive_new_companies, :boolean, :default => true
  	change_column :users, :receive_new_ads, :boolean, :default => true
  	change_column :users, :receive_updates, :boolean, :default => true
  end
end
