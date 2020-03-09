class CreateMembershipLandingpageFifthSections < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_landingpage_fifth_sections do |t|
      t.string :background
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
