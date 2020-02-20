ActiveAdmin.register SupportTopic do

  permit_params %i(name content title keywords description)

  form do |f|
    f.inputs 'Support Topic Details' do
      f.input :name
      f.input :content, as: :text, input_html: { class: 'tinymce' }
      f.input :title
      f.input :keywords
      f.input :description, as: :text, input_html: { class: 'tinymce' }
    end
    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
