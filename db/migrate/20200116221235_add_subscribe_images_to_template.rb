class AddSubscribeImagesToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :podcast_subscribe_images, :string
  end
end
