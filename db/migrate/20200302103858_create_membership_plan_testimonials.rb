class CreateMembershipPlanTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :membership_plan_testimonials do |t|
      t.string :image
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
