# frozen_string_literal: true

class RemindMailer < ApplicationMailer

  def free_listing_period_expire(listing)
    @listing = listing
    @owner_email = listing.user.email

    mail(to: @owner_email, subject: 'Your listing will expire in 5 days')
  end

  def new_subscription(listing)
    @listing = listing
    @owner_email = listing.user.email
    mail(to: @owner_email, subject: 'Subscription created')
  end
end
