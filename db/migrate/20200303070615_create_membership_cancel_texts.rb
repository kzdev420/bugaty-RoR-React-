class CreateMembershipCancelTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_cancel_texts do |t|
      t.string :title_1
      t.string :title_2
      t.string :title_3
      t.text :description

      t.timestamps
    end
  end
end
