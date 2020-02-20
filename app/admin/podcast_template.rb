ActiveAdmin.register Template, :as => 'Podcast Template' do
  menu :parent => "Podcast"
  actions :all, :except => [:create, :new, :destroy]

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params %i(podcast_header_image podcast_footer podcast_header_text podcast_contact_info podcast_newsletter podcast_header_menu podcast_subscribe_images)

  index do
    column :podcast_header_image
    column :podcast_header_text
    column :podcast_contact_info
    column :podcast_newsletter
    column :podcast_footer
    column :podcast_subscribe_images
    actions
  end

  show do
    attributes_table do
      row :podcast_header_image
      row :podcast_header_text
      row :podcast_contact_info
      row :podcast_footer
      row :podcast_newsletter
      row :podcast_subscribe_images
    end
  end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Podcast Template Details' do
          input :podcast_header_image, :as => :file, :hint => image_tag(f.object.podcast_header_image.present? ? f.object.podcast_header_image : '', width: '450')
          input :podcast_header_text
          input :podcast_header_menu, as: :text
          input :podcast_subscribe_images, as: :text
          input :podcast_footer, as: :text
          f.input :podcast_contact_info, as: :text, input_html: { class: 'tinymce' }
          f.input :podcast_newsletter, as: :text, input_html: { class: 'tinymce' }
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

