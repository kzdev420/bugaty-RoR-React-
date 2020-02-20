# frozen_string_literal: true

class PaymentRequest < ApplicationRecord
  extend PaymentRequestsEnum

  before_validation :set_state

  belongs_to :user
  belongs_to :listing

  scope :accepted, -> { where(state: request_states[:accepted]) }
  scope :available, -> { where('state = ? OR updated_at > ?', request_states[:open], 30.days.ago) }
  scope :open, -> { where(state: request_states[:open]) }
  scope :closed, -> { where('state > ?', request_states[:open]) }
  scope :purchases, -> { where(request_type: request_types[:purchase]) }
  scope :offers, -> { where(request_type: request_types[:offer]) }

  validates :listing, :payment_method, :price, :state, :request_type, :user, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :delivery_cost, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :state, inclusion: { in: request_states.values }
  validates :request_type, inclusion: { in: request_types.values }
  validates :message, length: { maximum: 300 }

  delegate :user, to: :listing, prefix: true
  delegate :name, to: :listing

  request_states.each do |key, value|
    define_method "#{key}?" do
      state == value
    end
  end

  request_types.each do |key, value|
    define_method "#{key}?" do
      request_type == value
    end
  end

  def total_amount
    amount = price
    amount += delivery_cost if delivery_cost.present?
    amount -= discount_amount(amount) if discount_code.present?
    amount
  end

  private

  def discount_amount(value)
    coupon_code = listing_user.coupon_codes.not_expired.where(name: discount_code).take
    coupon_code.nil? ? 0 : value / 100 * coupon_code.discount
  end

  def set_state
    self.state = PaymentRequest.request_states[:open] if state.nil?
  end
end
