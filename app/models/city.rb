class City < ApplicationRecord
  belongs_to :region
  has_many :listings, dependent: :nullify, inverse_of: :city

  validates :name, presence: true

  delegate :continent, :country, to: :region
end
