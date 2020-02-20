class SupportArticle < ApplicationRecord
  belongs_to :support_topic

  extend FriendlyId
  friendly_id :name, use: :slugged
end
