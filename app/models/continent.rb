class Continent < ApplicationRecord
  extend FriendlyId

  has_many :countries, dependent: :destroy, inverse_of: :continent
  has_many :regions, through: :countries
  has_many :cities, through: :regions
  has_many :listings, through: :cities

  friendly_id :name, use: :slugged

  validates :name, presence: true
end
