class BlogPost < ApplicationRecord
  extend FriendlyId
  include AASM

  belongs_to :blog_subcategory
  has_one :blog_category, through: :blog_subcategory
  has_many :blog_comments, dependent: :destroy

  mount_uploader :author_photo, AvatarUploader
  mount_uploader :cover_photo, AvatarUploader

  friendly_id :title, use: [:slugged, :finders]
  cattr_accessor :content_sanitize

  validates_presence_of :author

  aasm column: 'status' do
    state :draft, initial: true
    state :published

    event :draft do
      transitions from: :published, to: :draft
    end

    event :publish do
      transitions from: :draft, to: :published
    end
  end

end
