ActiveAdmin.register Page do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params %i(name slider text title keywords description)

  form do |f|

    f.inputs 'Page Details' do
      f.input :name
      f.input :text, as: :text, input_html: { class: 'tinymce', rows: '8' }
      f.input :slider, as: :text, input_html: { class: 'tinymce', rows: '8' }
      f.input :slug
      f.input :title
      f.input :keywords
      f.input :description, as: :text, input_html: { class: 'tinymce', rows: '8' }
    end
    f.actions
  end

  show do
    attributes_table do
      row :preview_link do
        link_to 'Preview', preview_url(page)
      end
      row :name
      row :text
      row :slider
      row :slug
      row :title
      row :keywords
      row :description
    end
    active_admin_comments
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
