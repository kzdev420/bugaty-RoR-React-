ActiveAdmin.register PodcastResource do
  menu :parent => "Podcast"

  permit_params PodcastResource.attribute_names

  index do
    column :id
    column :url
    column :cover_image
    column :podcast_episode
    actions
  end

  show do
    attributes_table do
      row :id
      row :url
      row :cover_image
      row :podcast_episode
    end
  end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Podcast Details' do
          input :url
          input :cover_image
          input :podcast_episode, :as => :select, :collection => PodcastEpisode.all.map {|u| [u.title, u.id]}, :include_blank => false
        end
      end
    end
    f.actions
  end

end