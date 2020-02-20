# frozen_string_literal: true

class CouponCodeMailer < ApplicationMailer

  def new_coupon_code(coupon_code)
    @coupon_code = coupon_code
    @owner_email = coupon_code.user.email
    mail(to: @owner_email, subject: 'New coupon code generated')
  end
end
