class AddTrialPeriodExpiringToEmailTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :email_templates, :trial_period_expiring, :text
  end
end
