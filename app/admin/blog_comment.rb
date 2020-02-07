ActiveAdmin.register BlogComment do
  menu :parent => "Blog"
  actions :all, :except => [:create, :new, :update, :edit]

  index do
    selectable_column
    column :content
    column :author do |object|
      "#{object.user.first_name} #{object.user.last_name}"
    end
    column :post do |object|
      auto_link(object.blog_post, object.blog_post.slug)
    end
    column :created_at
    column :published do |object|
      result = object.published? ? 'Yes' : 'No'
      raw "<p class='active-admin-badge-#{result == 'No' ? 'red' : 'green' }'>#{result}</p>"
    end
    actions defaults: true do |comment|
      link_to comment.published? ? "Hide" : 'Publish', change_status_admin_blog_comment_path(comment), method: :put
    end
  end

  show do
    attributes_table do

      row :id
      row :content
      row :author do |object|
        "#{object.user.first_name} #{object.user.last_name}"
      end
      row :post do |object|
        auto_link(object.blog_post, object.blog_post.slug)
      end
      row :created_at
      row :published do |object|
        result = object.published? ? 'Yes' : 'No'
        raw "<p class='active-admin-badge-#{result == 'No' ? 'red' : 'green' }'>#{result}</p>"
      end
      active_admin_comments
    end
  end

  action_item :publish, only: :show do
    link_to blog_comment.published? ? "Hide" : 'Publish', change_status_admin_blog_comment_path(blog_comment), method: :put
  end


  form do |f|
    f.inputs "Comment Details" do
        f.input :content
    end
    f.button :Submit
  end

  member_action :change_status, method: :put do
    comment = BlogComment.find(params[:id])
    comment.published? ? comment.hide! : comment.publish!
    redirect_to admin_blog_comment_path(comment)
  end

end