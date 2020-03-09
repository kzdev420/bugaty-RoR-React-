class CreatePodcastHosts < ActiveRecord::Migration[5.0]
  def change
    create_table :podcast_hosts do |t|
      t.string :profile_picture_1
      t.string :profile_picture_2
      t.string :description

      t.timestamps
    end
  end
end
