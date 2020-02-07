if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUB_KEY'],
    secret_key: ENV['STRIPE_SECRET']
  }
else
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_TEST_PUB_KEY'],
    secret_key: ENV['STRIPE_TEST_SECRET']
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
