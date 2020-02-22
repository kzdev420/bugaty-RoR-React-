class AddCountersToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :new_requests_count, :integer, default: 0
    add_column :users, :new_replies_count, :integer, default: 0
  end
end
