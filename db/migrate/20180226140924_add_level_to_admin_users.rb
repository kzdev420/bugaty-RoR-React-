# frozen_string_literal: true

class AddLevelToAdminUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_users, :level, :integer, default: 0
  end
end
