class AddUsertoFeedback < ActiveRecord::Migration[5.0]
  def change
  	add_column :feedbacks, :user_id, :integer
  end
end
