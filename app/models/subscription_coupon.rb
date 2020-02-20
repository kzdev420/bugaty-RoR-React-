# frozen_string_literal: true

class SubscriptionCoupon < ApplicationRecord
  extend SubscriptionCouponsEnum

  before_validation :set_state
  before_create :create_stripe_coupon
  after_destroy :delete_stripe_coupon

  scope :not_used, -> { where('state = ?', 0) }

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :discount, numericality: { greater_than: 0 }
  validates :state, inclusion: { in: coupon_states.values }

  coupon_states.each do |key, value|
    define_method "#{key}?" do
      state == value
    end
  end

  def coupon_state
    SubscriptionCoupon.coupon_states.select { |_key, value| value == state }.first.first.to_s
  end

private

  def set_state
    self.state = SubscriptionCoupon.coupon_states[:free] if state.nil?
  end

  def create_stripe_coupon
    return if self.stripe_id

    coupon = Stripe::Coupon.create({
      name: name,
      duration: 'once',
      percent_off: discount,
      currency: 'GBP'
    })
    self.stripe_id = coupon.id
  end

  def delete_stripe_coupon
    coupon = Stripe::Coupon.retrieve(stripe_id)
    coupon.delete
  end
end
