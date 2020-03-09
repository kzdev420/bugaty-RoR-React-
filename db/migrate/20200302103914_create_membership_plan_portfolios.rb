class CreateMembershipPlanPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_plan_portfolios do |t|
      t.string :image
      t.string :title
      t.text :description
      
      t.timestamps
    end
  end
end
