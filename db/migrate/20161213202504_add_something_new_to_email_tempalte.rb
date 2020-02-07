class AddSomethingNewToEmailTempalte < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :user_message_user, :text
  end
end
