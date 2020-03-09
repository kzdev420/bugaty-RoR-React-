module Blog
  module SetHeaderValues
    extend ActiveSupport::Concern
    included do
      def set_blog_header_values
        @blog_category = BlogCategory.all
        @top_menu = $template.blog_header_menu
        @menu_posts = {}
        all_blog_posts = BlogPost.joins(:blog_subcategory,).published.where(featured: false).group('blog_posts.id, blog_subcategories.blog_category_id').having("count(*) <= 7")
        BlogCategory.all.each do |category|
          filtered_blogs = all_blog_posts.where(blog_subcategory_id: category.blog_subcategories.ids)
          featured_post = BlogPost.published.find_by(featured: true, blog_subcategory_id: category.blog_subcategories.ids)
          @menu_posts[category.slug] = {
            recents: collection_serialize(BlogPost.published.where(blog_subcategory_id: category.blog_subcategories.ids).limit(3), BlogPostSerializer),
            featured: featured_post.present? ?  BlogPostSerializer.new(featured_post) : nil
          }
        end
      end

      def collection_serialize(object, serializer)
        ActiveModel::Serializer::CollectionSerializer.new(object, serializer: serializer)
      end

    end
  end
end
