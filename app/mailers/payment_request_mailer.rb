# frozen_string_literal: true

class PaymentRequestMailer < ApplicationMailer

  def new_payment_request(payment_request)
    @payment_request = payment_request
    @seller_email = payment_request.listing_user.email
    mail(to: @seller_email, subject: 'New payment details request')
  end

  def new_offer(payment_request)
    @payment_request = payment_request
    @seller_email = payment_request.listing_user.email
    mail(to: @seller_email, subject: 'New offer')
  end

  def payment_request_approval_notice(payment_request)
    @payment_request = payment_request
    mail(to: @payment_request.user.email, subject: 'Your payment request was accepted')
  end

  def payment_request_deny_notice(payment_request)
    @payment_request = payment_request
    mail(to: @payment_request.user.email, subject: 'Your payment request was rejected')
  end

  def offer_approval_notice(payment_request)
    @payment_request = payment_request
    mail(to: @payment_request.user.email, subject: 'Your offer was accepted')
  end

  def offer_deny_notice(payment_request)
    @payment_request = payment_request
    mail(to: @payment_request.user.email, subject: 'Your offer was rejected')
  end
end
