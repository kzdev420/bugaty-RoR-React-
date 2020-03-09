class CreatePages < ActiveRecord::Migration[5.0]
  def up
    create_table :pages do |t|
      t.string :name, null: false
      t.text :text
      t.text :slider
      t.string :slug
      t.string :title
      t.string :keywords
      t.text :description

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end

  def down
    drop_table :pages
  end
end
