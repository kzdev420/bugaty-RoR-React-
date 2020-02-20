class BlogCommentSerializer < ApplicationSerializer
  include ActionView::Helpers::DateHelper

  attributes :id, :content, :user, :created_at

  def user
    UserSerializer.new(object.user)
  end

  def created_at
    time_ago_in_words(object.created_at)
  end
end
