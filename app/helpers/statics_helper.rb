module StaticsHelper
  def contact_subject_options
    [
      'Account Support',
      'Ads Support',
      'Report a Bug',
      'General Enquiry',
      'Advertisement'
    ]
  end

  def sitemap_weight(sitemap)
    sitemap.inject(0) { |sum, item| sum += item[:weight] }
  end

  def sitemap_link(link, css_class = '')
    if link.include?(:url)
      str = "<li> <a href =\"#{link[:url]}\""
      str += "class=#{css_class}" unless css_class.empty?
      str += ">#{link[:name]}</a>"
    else
      str = "<li>#{link[:name]}"
    end

    if link.include?(:children) && !link[:children].empty?
      str += '<ul class="sitemap">'
      link[:children].each do |child|
        str += sitemap_link(child)
      end
      str += '</ul>'
    end
    str += '</li>'
  end
end
