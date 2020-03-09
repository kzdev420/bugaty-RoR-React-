class CreateMembershipLandingpageSecondSections < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_landingpage_second_sections do |t|
      t.string :image
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
