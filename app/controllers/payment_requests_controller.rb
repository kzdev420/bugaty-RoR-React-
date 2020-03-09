#frozen_string_literal: true

class PaymentRequestsController < ApplicationController
  ITEMS_PER_PAGE = 10

  before_action :authenticate_user!

  def create
    payment_request = current_user.payment_requests.create!(payment_request_params)
    if payment_request.request_type == PaymentRequest.request_types[:purchase]
      PaymentRequestMailer.new_payment_request(payment_request).deliver_later
    elsif payment_request.request_type == PaymentRequest.request_types[:offer]
      PaymentRequestMailer.new_offer(payment_request).deliver_later
    end

    payment_request.listing_user.increment!(:new_requests_count)

    redirect_to listing_path(payment_request_params[:listing_id]), notice: 'Payment request was successfully added'
  end

  def incoming
    items_number = params[:pagination_select] || ITEMS_PER_PAGE

    @payment_requests = PaymentRequest
      .where('listing_id IN (?)', current_user.listings.pluck(:id))
      .order(updated_at: :desc)
      .page(params[:page])
      .per_page(items_number)

    if @payment_requests.size.positive?
      counter = current_user.new_requests_count - @payment_requests.size
      counter = 0 if counter.negative?

      current_user.update!(new_requests_count: counter)
    end
  end

  def sent
    items_number = params[:pagination_select] || ITEMS_PER_PAGE

    @payment_requests = current_user
      .payment_requests
      .available
      .order(updated_at: :desc)
      .page(params[:page])
      .per_page(items_number)

    if @payment_requests.size.positive?
      counter = current_user.new_replies_count - @payment_requests.size
      counter = 0 if counter.negative?

      current_user.update!(new_replies_count: counter)
    end
  end

  def update
    payment_request = PaymentRequest.find(params[:id])
    payment_request.update!(payment_request_params)

    if payment_request.listing_user == current_user
      if payment_request.accepted?
        flash[:success] = 'You accepted payment request'

        if payment_request.request_type == PaymentRequest.request_types[:purchase]
          PaymentRequestMailer.payment_request_approval_notice(payment_request).deliver_later
        elsif payment_request.request_type == PaymentRequest.request_types[:offer]
          PaymentRequestMailer.offer_approval_notice(payment_request).deliver_later
        end
      else
        flash[:error] = 'You rejected payment request'

        if payment_request.request_type == PaymentRequest.request_types[:purchase]
          PaymentRequestMailer.payment_request_deny_notice(payment_request).deliver_later
        elsif payment_request.request_type == PaymentRequest.request_types[:offer]
          PaymentRequestMailer.offer_deny_notice(payment_request).deliver_later
        end
      end

      payment_request.user.increment!(:new_replies_count)

      redirect_to incoming_requests_path
    end
  end

  def batch_delete
    @payment_requests = current_user.payment_requests.where(id: params[:listings].split(','))
    @payment_requests.destroy_all
    redirect_to sent_requests_path, notice: 'These payment requests were deleted successfully'
  end

  def check_coupon_code
    user = Listing.find(params[:listing_id]).try(:user)
    if user
      coupon_code = user.coupon_codes.not_expired.find_by(name: params[:q])
      discount_percentage = coupon_code.try(:discount)
    end

    discount_percentage ||= 0

    render json: {discount: discount_percentage.to_f}
  end

  private

  def payment_request_params
    params
      .require(:payment_request)
      .permit(
        :delivery_cost, :details, :discount_code, :listing_id, :message, :payment_method,
        :price, :reply_message, :request_type, :state
      )
  end
end
