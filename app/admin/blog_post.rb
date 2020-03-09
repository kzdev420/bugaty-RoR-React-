ActiveAdmin.register BlogPost do
  menu :parent => "Blog"
  include ActiveModel::Dirty
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params BlogPost.attribute_names + [:blog_categories]
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  index do
    selectable_column
    column :title
    column :author
    column :subcategory do |object|
      object.blog_subcategory.title
    end
    column :tags
    actions
  end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Post Details' do
          input :title
          input :cover_photo, :as => :file, :hint => image_tag(f.object.cover_photo.present? ? f.object.cover_photo : '', width: '250'), label: "Cover photo (ideal size: 1000x500)"
          input :tag, label: 'Tags (separate them by commas):'
          input :blog_subcategory, :as => :select, :collection => BlogSubcategory.all.map {|u| [u.title, u.id]}, :include_blank => false
          f.input :content, as: :text, input_html: { class: 'tinymce' }
          input :script_tags
          input :featured
        end
        f.inputs 'Author Details' do
          input :author
          input :author_photo, :as => :file, :hint => image_tag(f.object.author_photo.present? ? f.object.author_photo : '', width: '90'), label: "Author photo (ideal size: 90x90)"
          input :bio, label: 'Author Biography'
        end
      end
    end
    f.actions
  end
  show title: proc { |post| "#{post.title} (#{post.status.capitalize})" } do
    attributes_table  do
      row :id
      row :title
      row :cover_photo do |object|
        image_tag object.cover_photo.url || '', width: '250'
      end
      row :tag
      row :blog_subcategory
      row :content
      row :featured
      row :author
      row :author_photo do |object|
        image_tag object.author_photo.url || '', width: '90'
      end
      row :bio, label: 'Author Biography'
    end
  end

  def display_name
    return self.id.to_s + '-' + self.email
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  action_item :publish, only: :show do
    link_to blog_post.published? ? 'Set as draft' : 'Publish Post' , change_status_admin_blog_post_path(blog_post), method: :put
  end

  action_item :visit, only: :show do
    link_to 'Visit Post' , blog_post_path(blog_post.slug)
  end

  member_action :change_status, method: :put do
    post = BlogPost.friendly.find(params[:id])
    post.published? ? post.draft! : post.publish!
    redirect_to admin_blog_post_path(post)
  end


end
