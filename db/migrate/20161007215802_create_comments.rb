class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.string :rating

      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true
      t.timestamps
    end
  end
end
