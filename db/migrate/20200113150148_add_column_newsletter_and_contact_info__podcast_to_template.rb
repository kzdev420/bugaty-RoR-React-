class AddColumnNewsletterAndContactInfoPodcastToTemplate < ActiveRecord::Migration[5.0]
  def change
    add_column :templates, :podcast_contact_info, :string
    add_column :templates, :podcast_newsletter, :string
  end
end
