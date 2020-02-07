class PodcastsController < ApplicationController
  before_action :set_header_variables

  def index
    @podcast_episodes = paginate PodcastEpisode.all.order(created_at: :desc)
    @podcast_episodes = ActiveModel::Serializer::CollectionSerializer.new(@podcast_episodes, serializer: TinyPodcastEpisodeSerializer)
    respond_to do |format|
      format.json { render json: @podcast_episodes.to_json}
      format.html do
        @podcast_host = PodcastHostSerializer.new(PodcastHost.first)
        @total_items = PodcastEpisode.count
        render :index
      end
    end
  end

  def show
    @podcast_episode = PodcastEpisodeSerializer.new(PodcastEpisode.friendly.find(params[:id]))
    @featured_episodes = ActiveModel::Serializer::CollectionSerializer.new(PodcastEpisode.all.where.not(id: @podcast_episode.object.id).order(created_at: :desc).limit(3), serializer: TinyPodcastEpisodeSerializer)

    respond_to do |format|
      format.json { render json: @podcast_episode.to_json}
      format.html { render :show }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to podcasts_path
  end

  def subscribe
    name, email = params[:name], params[:email]
    PodcastSubscriber.create!(name: name, email: email)
    options = {
      form: {
        api_key: ENV['SENDY_API_KEY'],
        name: name,
        email: email,
        list: ENV['SENDY_LIST_ID_PODCAST']
      }
    }
    response = HTTP.post(ENV['SENDY_URL'] + '/subscribe', options)
    head :ok
  rescue Exception => ex
    head 422
  end

  private

  def per_page
    @per_page = params[:per_page] || 5
  end

  def page
    @page = params[:page]
  end

  def paginate(scope)
    scope.page(page).per(per_page)
  end

  def set_header_variables
    @header_menu = $template.podcast_header_menu
  end

end
