class Comment < ApplicationRecord
  belongs_to :listing, counter_cache: true
  belongs_to :user
  has_many :comment_replies

  validates :rating, presence: true
  validates :content, presence: true
end
