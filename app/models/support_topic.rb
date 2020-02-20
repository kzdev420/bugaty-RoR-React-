class SupportTopic < ApplicationRecord
  has_many :support_articles

  extend FriendlyId
  friendly_id :name, use: :slugged
end
