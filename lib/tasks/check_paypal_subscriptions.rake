desc 'Check PayPal subscriptions are they active or not'

task :check_paypal_subscriptions => :environment do
  Listing.where('subscribed_until < :final_date AND paypal_id IS NOT NULL', final_date: Time.current).find_each do |listing|
    ppr = PayPal::Recurring.new(profile_id: listing.paypal_id)
    response = ppr.profile
    if response.active?
      plan_period = listing.subscription_plan.period.gsub('-', '').strip
      end_period = listing.subscribed_until + plan_period.to_i.days
      listing.update(subscribed_until: end_period)
    else
      listing.update(paypal_id: nil, subscription_plan: nil)
    end
  end
end
