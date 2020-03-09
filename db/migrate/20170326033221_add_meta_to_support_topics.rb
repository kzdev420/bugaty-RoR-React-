class AddMetaToSupportTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :support_topics, :title, :string
    add_column :support_topics, :keywords, :string
    add_column :support_topics, :description, :text

    add_column :support_articles, :title, :string
    add_column :support_articles, :keywords, :string
    add_column :support_articles, :description, :text
  end
end
