class AddSlugToSupportTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :support_topics, :slug, :string
    add_column :support_articles, :slug, :string

    add_index :support_topics, :slug, unique: true
    add_index :support_articles, :slug, unique: true
  end
end
