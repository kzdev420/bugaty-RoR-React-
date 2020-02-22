class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.integer :published, default: 1
      t.string :name
      t.string :brand
      t.string :condition
      t.string :location
      t.text :description
      t.string :delivery_time
      t.string :delivery_cost
      t.string :pick_up_only
      t.integer :price
      t.string :price_open_to_offers
      t.string :price_per
      t.string :salary_per
      t.string :price_per_property

      t.string :car_make
      t.string :car_model
      t.string :car_reg_year
      t.string :car_gearbox
      t.string :car_mileage
      t.string :car_engine_size
      t.string :car_fuel_type
      t.string :car_body_type
      t.string :car_color

      t.string :job_type

      t.string :property_type
      t.string :property_size_rooms
      t.string :property_size_meters
      t.string :property_size_feets
      t.string :property_date_available

      t.string :video_url

      t.string :pet_type

      t.string :featured_home
      t.datetime :featured_home_date
      t.string :featured_cat
      t.datetime :featured_cat_date
      t.string :featured_all
      t.datetime :featured_all_date
      t.string :urgent
      t.datetime :urgent_date

      t.references :user, index: true, foreign_key: true
      t.references :category
      t.references :subcategory
      t.timestamps
    end
  end
end
