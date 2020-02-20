ActiveAdmin.register BlogSubcategory do
  menu :parent => "Blog"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params %i(title blog_category_id slug)

  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :title
    column :slug
    column :blog_category
    column :created_at
    column :updated_at
    actions
  end


  form do |f|
    f.inputs 'Details' do
      input :title
      input :slug
      input :blog_category, :as => :select, :collection => BlogCategory.all.map {|u| [u.title, u.id]}, :include_blank => false
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
