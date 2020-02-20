ActiveAdmin.register PodcastEpisode do
  menu :parent => "Podcast"

  permit_params PodcastEpisode.attribute_names

  index do
    selectable_column
    column :id
    column :title
    column :small_description
    column :content
    column :embedded_podcast
    column :preview_podcast
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :small_description
      row :content
      row :embedded_podcast
      row :preview_podcast
    end
  end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Podcast Details' do
          input :title
          input :small_description
          input :preview_podcast
          input :embedded_podcast
          f.input :content, as: :text, input_html: { class: 'tinymce' }
        end
      end
    end
    f.actions
  end

  action_item :visit, only: :show do
    link_to 'Visit Podcast', episodes_podcasts_path(podcast_episode.slug)
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end


end