class AddColumnsToEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :new_payment_request, :text
    add_column :email_templates, :new_offer, :text
    add_column :email_templates, :payment_request_accepted, :text
    add_column :email_templates, :offer_accepted, :text
    add_column :email_templates, :payment_request_rejected, :text
    add_column :email_templates, :offer_rejected, :text
    add_column :email_templates, :new_coupon_code, :text
  end
end
