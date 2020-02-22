class AddPodcastFooterBlogFooterToTemplates < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :blog_footer, :string
    add_column :templates, :podcast_footer, :string
  end
end
