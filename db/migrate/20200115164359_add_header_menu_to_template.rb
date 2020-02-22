class AddHeaderMenuToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :podcast_header_menu, :string
  end
end
