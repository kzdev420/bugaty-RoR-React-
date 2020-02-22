class CreatePodcastSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :podcast_subscribers do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
