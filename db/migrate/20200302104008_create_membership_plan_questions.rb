class CreateMembershipPlanQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_plan_questions do |t|
      t.string :question

      t.timestamps
    end
  end
end
