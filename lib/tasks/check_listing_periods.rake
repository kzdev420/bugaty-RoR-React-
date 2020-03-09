desc 'Check listing free periods and send reminder mails'

task :check_listing_periods => :environment do
  Listing.where('subscribed_until >= :start_date AND subscribed_until < :final_date AND subscription_stripe_id IS NULL AND paypal_id IS NULL', start_date: 4.days.from_now, final_date: 5.days.from_now).find_each do |listing|
    RemindMailer.free_listing_period_expire(listing).deliver
  end
end
