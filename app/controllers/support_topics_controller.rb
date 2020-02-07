class SupportTopicsController < ApplicationController
  def show_category
    find_topic
    @all_topics = SupportTopic.all
  end

  def show_article
    find_topic
    find_article
    @all_topics = SupportTopic.all
  end

  def support_search
    @all_topics = SupportTopic.all
    if params[:search]
      @search_results = SupportArticle.search(search_params).result
    else
      @search_results = {}
    end
  end

  private

  def find_topic
    @support_topic = SupportTopic.friendly.find(params[:support_topic_slug])
  end

  def find_article
    @support_article = SupportArticle.friendly.find(params[:support_article_slug])
  end

  def search_params
    { name_cont: params[:search], content_cont: params[:search], m: 'or' }
  end
end
