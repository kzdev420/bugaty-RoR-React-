class AddConditionToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :condition, :string
  end
end
