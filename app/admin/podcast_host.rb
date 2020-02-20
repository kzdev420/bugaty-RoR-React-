ActiveAdmin.register PodcastHost do
  menu :parent => "Podcast"
  actions :all, :except => [:create, :new, :destroy]

  permit_params PodcastHost.attribute_names

  index do
    column :profile_picture_1
    column :profile_picture_2
    column :description
    actions
  end

  show do
    attributes_table do
      row :profile_picture_1 do |object|
        image_tag object.profile_picture_1.url || '', width: '150'
      end
      row :profile_picture_2 do |object|
        image_tag object.profile_picture_2.url || '', width: '150'
      end
      row :description
    end
  end

  form do |f|
    f.inputs "Host Details" do
        f.input :description, as: :text, input_html: { class: 'tinymce' }
        f.input :profile_picture_1, :hint => image_tag(f.object.profile_picture_1.present? ? f.object.profile_picture_1 : '', width: '150'), label: "Photo 1 (ideal size: 150x150)"
        f.input :profile_picture_2, :hint => image_tag(f.object.profile_picture_2.present? ? f.object.profile_picture_2 : '', width: '150'), label: "Photo 2 (ideal size: 150x150)"
    end
    f.button :Submit
  end

end