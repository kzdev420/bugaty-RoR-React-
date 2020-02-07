ActiveAdmin.register PodcastSubscriber do
  menu :parent => "Podcast"
  actions :all, :except => [:create, :new, :edit, :update, :destroy]

  permit_params PodcastHost.attribute_names

  index do
    column :name
    column :email
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
    end
  end

end