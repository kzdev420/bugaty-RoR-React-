class TinyPodcastEpisodeSerializer < ApplicationSerializer
  attributes :title, :slug, :small_description, :content, :embedded_podcast, :created_at, :preview_podcast_script, :preview_podcast_div

  def created_at
    object.created_at.strftime("%B %d, %Y")
  end

  def embedded_podcast
    return [] unless object.embedded_podcast.present?
    script = Nokogiri::HTML.parse(object.embedded_podcast).xpath('//script/@src')
    return [] if script.blank?
    script.map(&:value)
  end

  def preview_podcast_script
    return '' unless object.preview_podcast.present?
    script = Nokogiri::HTML.parse(object.preview_podcast).xpath('//script/@src')
    return '' if script.blank?
    script.first.value
   end

  def preview_podcast_div
    return '' unless object.preview_podcast.present?
    div = Nokogiri::HTML.parse(object.preview_podcast).search('div').to_html
    return div if div.present?
    iframe = Nokogiri::HTML.parse(object.preview_podcast).search('iframe').to_html
    return iframe if iframe.present?
  end

end
