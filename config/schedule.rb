every 5.minutes do
  rake '-s sitemap:refresh'
end

every 1.day, at: '01:00' do
  rake 'check_payment_dates'
end

every 1.day, at: '02:00' do
  rake 'check_listing_periods'
end

every 1.day, at: '03:00' do
  rake 'check_paypal_subscriptions'
end
