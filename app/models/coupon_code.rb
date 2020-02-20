# frozen_string_literal: true

class CouponCode < ApplicationRecord
  belongs_to :user

  scope :available, -> { where('expiration_date > ?', 30.days.ago) }
  scope :not_expired, -> { where('expiration_date >= ?', Date.current) }

  validates :expiration_date, :name, :user, presence: true
  validates :discount, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 99 }
  validates :name, format: { with: /\A[a-z\d]*\Z/i, message: 'only allows letters and digits' }
  validates :name, length: { maximum: 20 }
end
