#frozen_string_literal: true

class CouponCodesController < ApplicationController
  def index
    @coupon_codes = current_user.coupon_codes.available.order(expiration_date: :desc)
    @coupon_code = current_user.coupon_codes.new
  end

  def create
    @coupon_code = current_user.coupon_codes.new(coupon_codes_params)

    if @coupon_code.save
      CouponCodeMailer.new_coupon_code(@coupon_code).deliver_later
      redirect_to coupon_codes_path, notice: 'Coupon code was generated successfully'
    else
      flash.now[:error] = 'Please fix existing errors'
      @coupon_codes = current_user.coupon_codes.available.order(expiration_date: :desc)
      render :index
    end
  end

  private

  def coupon_codes_params
    params.require(:coupon_code).permit(:discount, :expiration_date, :name, :user_id)
  end
end
