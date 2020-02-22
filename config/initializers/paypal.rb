if Rails.env.production?
  PayPal::Recurring.configure do |config|
    config.sandbox = false
    config.username = ENV['PAYPAL_LOGIN_PROD']
    config.password = ENV['PAYPAL_PASSWORD_PROD']
    config.signature = ENV['PAYPAL_SECRET_PROD']
  end
else
  PayPal::Recurring.configure do |config|
    config.sandbox = true
    config.username = ENV['PAYPAL_LOGIN']
    config.password = ENV['PAYPAL_PASSWORD']
    config.signature = ENV['PAYPAL_SECRET']
  end
end
