class Region < ApplicationRecord
  belongs_to :country
  has_many :cities, dependent: :destroy, inverse_of: :region
  has_many :listings, through: :cities

  validates :name, presence: true

  delegate :continent, to: :country
end
