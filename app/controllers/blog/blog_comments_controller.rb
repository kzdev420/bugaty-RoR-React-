module Blog
  class BlogCommentsController < ApplicationController

    def create
      blog_post = BlogPost.published.friendly.find(params[:post_id])
      blog_post.blog_comments.create!(content: params[:content], user_id: current_user.id)
      head :ok
    rescue
      render json: nil, status: 422
    end

  end
end