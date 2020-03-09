class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :language
      t.string :location
      t.string :profile_photo
      t.string :cover_photo
      t.datetime :last_active
      t.text :description

      t.boolean :receive_new_companies
      t.boolean :receive_new_ads
      t.boolean :receive_updates

      t.timestamps
    end
  end
end
