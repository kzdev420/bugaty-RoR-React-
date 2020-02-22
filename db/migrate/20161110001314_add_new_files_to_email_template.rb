class AddNewFilesToEmailTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :email_templates, :listing_new_user, :text
  	add_column :email_templates, :review_alert, :text
  	add_column :email_templates, :user_close_account, :text
  	add_column :email_templates, :expiration_notice, :text
  	add_column :email_templates, :approval_notice, :text
  	add_column :email_templates, :deny_notice, :text
  end
end
