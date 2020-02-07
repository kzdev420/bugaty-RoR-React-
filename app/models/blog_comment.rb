class BlogComment < ApplicationRecord
  include AASM

  belongs_to :user, required: true
  belongs_to :blog_post, required: true

  validates :content, length: { maximum: 200 }

  aasm column: 'status' do
    state :hidden, initial: true
    state :published

    event :hide do
      transitions from: :published, to: :hidden
    end

    event :publish do
      transitions from: :hidden, to: :published
    end
  end

end
