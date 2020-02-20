class DetailedBlogPostSerializer < ::BlogPostSerializer
  attributes :next_post, :previous_post, :comments, :recommended

  def next_post
    post = BlogPost.published.where("id > ?", object.id).first
    return if post.nil?
    ::BlogPostSerializer.new(post)
  end

  def previous_post
    post = BlogPost.published.where("id < ?", object.id).last
    return if post.nil?
    ::BlogPostSerializer.new(post)
  end

  def comments
    ActiveModel::Serializer::CollectionSerializer.new(object.blog_comments.published, serializer: BlogCommentSerializer)
  end

  def recommended
    recommended = BlogPost.published.where(blog_subcategory_id: object.blog_subcategory_id).where.not(id: object.id).to_a
    recommended = BlogPost.published.joins(:blog_category).where(blog_categories: { id: object.blog_category.id } ).where.not(id: recommended.to_a.push(object.id)) if recommended.count < 3
    recommended = BlogPost.published.where.not(id: recommended.to_a.push(object.id)) if recommended.count < 3
    recommended = recommended.first(3)
    ActiveModel::Serializer::CollectionSerializer.new(recommended, serializer: BlogPostSerializer)
  end

end