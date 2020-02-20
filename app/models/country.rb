class Country < ApplicationRecord
  extend FriendlyId

  belongs_to :continent
  has_many :regions, dependent: :destroy, inverse_of: :country
  has_many :cities, through: :regions
  has_many :listings, through: :cities

  friendly_id :name, use: :slugged

  validates :name, presence: true
end
