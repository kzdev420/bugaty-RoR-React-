class PodcastEpisodeSerializer < ApplicationSerializer
  attributes :title, :slug, :small_description, :content, :embedded_podcast, :created_at, :resources, :next_podcast, :previous_podcast

  def created_at
    object.created_at.strftime("%B %d, %Y")
  end

  def resources
    ActiveModel::Serializer::CollectionSerializer.new(object.podcast_resources, serializer: PodcastResourceSerializer)
  end

  def next_podcast
    podcast = PodcastEpisode.where("id > ?", object.id).first
    return if podcast.nil?
    TinyPodcastEpisodeSerializer.new(podcast)
  end

  def previous_podcast
    podcast = PodcastEpisode.where("id < ?", object.id).last
    return if podcast.nil?
    TinyPodcastEpisodeSerializer.new(podcast)
  end

  def embedded_podcast
    return [] unless object.embedded_podcast.present?
    script = Nokogiri::HTML.parse(object.embedded_podcast).xpath('//script/@src')
    return [] if script.blank?
    script.map(&:value)
   end


  def content
    frag = Nokogiri::HTML.parse(object.content)
    embeds = frag.search('iframe')
    embeds.wrap("<div class='iframeContainer'>") if embeds.count > 0
    frag.to_html
  end

end
