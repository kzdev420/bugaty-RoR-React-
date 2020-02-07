class AddNewSubscriptionToEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :new_subscription, :text
  end
end
