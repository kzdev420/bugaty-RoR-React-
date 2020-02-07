class AddColumnPodscastHeaderImageAndPodscastHeaderTextToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :podcast_header_image, :string
    add_column :templates, :podcast_header_text, :string
  end
end
