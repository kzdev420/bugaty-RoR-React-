class BlogPostSerializer < ApplicationSerializer
  attributes :id, :title, :content, :content_sanitize, :created_at, :author, :author_photo, :bio, :cover_photo, :blog_subcategory, :slug, :comments_amount, :tag, :script_tags

  def blog_subcategory
    object.blog_subcategory.title
  end

  def content
    frag = Nokogiri::HTML.parse(object.content)
    embeds = frag.search('iframe')
    embeds.wrap("<div class='iframeContainer'>") if embeds.count > 0
    frag.to_html
  end

  def content_sanitize
    ActionView::Base.full_sanitizer.sanitize(object.content)
  end

  def cover_photo
    object.cover_photo&.url
  end

  def author_photo
    object.author_photo&.url
  end

  def created_at
    object.created_at.strftime("%B %d, %Y")
  end

  def comments_amount
    object.blog_comments.published.count
  end

  def script_tags
    return [] unless object.script_tags.present?
    script = Nokogiri::HTML.parse(object.script_tags).xpath('//script/@src')
    return [] if script.blank?
    script.map(&:value)
  end

end
