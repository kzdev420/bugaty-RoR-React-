ActiveAdmin.register Template, :as => 'Blog Template' do
  menu :parent => "Blog"
  actions :all, :except => [:create, :new, :destroy]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params %i(blog_header_menu blog_footer)

  index do
    column :blog_header_menu
    column :blog_footer
    actions
  end

  show do
    attributes_table do
      row :blog_header_menu
      row :blog_footer
    end
  end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Blog Template Details' do
          input :blog_header_menu, as: :text
          input :blog_footer, as: :text
        end
      end
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        format.html {
          $template.reload
          redirect_to :back
         }
      end
    end
  end

  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  end

