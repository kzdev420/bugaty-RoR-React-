class AddSlugToContinents < ActiveRecord::Migration[5.0]
  def change
    add_column :continents, :slug, :string
    add_index :continents, :slug, unique: true
  end
end
