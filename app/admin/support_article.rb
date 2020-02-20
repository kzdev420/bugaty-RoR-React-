ActiveAdmin.register SupportArticle do

  permit_params %i(name content support_topic_id title keywords description)

  form do |f|
    f.inputs 'Support Article Details' do
      f.input :support_topic_id, as: :select, collection: SupportTopic.order(:name)
      f.input :name
      f.input :content, as: :text, input_html: { class: 'tinymce' }
      f.input :slug
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
