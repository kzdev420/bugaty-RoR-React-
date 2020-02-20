module Blog
  class BlogPostsController < ApplicationController
    include Blog::SetHeaderValues

    before_action :set_blog_header_values

    def index
      @blog_posts = BlogPost.published
      unless params[:search].present?
        category = BlogCategory.find_by(slug: params[:category])
        subcategory = BlogSubcategory.find_by(slug: params[:subcategory])

        if category.present?
          @category = BlogCategorySerializer.new(category)
          @blog_posts = @blog_posts.where(blog_subcategory_id: category.blog_subcategories.ids).order(created_at: :desc)
        elsif subcategory.present?
          @subcategory = BlogSubcategorySerializer.new(subcategory)
          @blog_posts = @blog_posts.where(blog_subcategory_id: subcategory.id).order(created_at: :desc)
        end
        featured_posts = @blog_posts.where(featured: true).limit(4)
        @featured_posts = collection_serialize(featured_posts, BlogPostSerializer)
        @blog_posts = @blog_posts.where.not(id: featured_posts.ids)
      else
        @featured_posts = []
      end


      if params[:search].present?
        @search = params[:search]
        if params[:tag].present?
          @blog_posts = @blog_posts.where("tag ilike ?", "%#{@search}%")
        else
          @blog_posts = @blog_posts.where("title ilike ? OR tag ilike ? OR content ilike ?", "%#{@search}%","%#{@search}%","%#{@search}%")
        end
      end

      @total_items = @blog_posts.count
      @blog_posts = collection_serialize(paginate(@blog_posts), BlogPostSerializer)

      respond_to do |format|
        format.json { render json: @blog_posts.to_json}
        format.html { render :index }
      end

    end

    def show
      blog_post = BlogPost.published.friendly.find(params[:id])
      @blog_post = DetailedBlogPostSerializer.new(blog_post)

      respond_to do |format|
        format.json { render json: @blog_post.to_json}
        format.html { render :show }
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to blog_path
    end

    private

    def per_page
      @per_page = params[:per_page] || 9
    end

    def page
      @page = params[:page]
    end

    def paginate(scope)
      scope.page(page).per(per_page)
    end

  end
end