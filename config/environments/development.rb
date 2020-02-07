Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  # config.assets.quiet = true

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.default_options = { from: 'development@mail.com', to: 'ex@mail.com' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.asset_host = config.action_controller.asset_host

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.log_level = :debug

  # Suppress logger output for asset requests.
  # config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # ActionMailer::Base.smtp_settings = {
  #   :user_name => ENV['AWS_MAIL_USER'],
  #   :password => ENV['AWS_MAIL_PASS'],
  #   :domain => 'globsucceed.com',
  #   :address => ENV['AWS_MAIL_ADRESS'],
  #   :port => 587,
  #   :authentication => :login,
  #   :enable_starttls_auto => true
  # }

    # config.action_mailer.smtp_settings = {
    #   :user_name => 'cb5dec417ca2e9',
    #   :password => '57493d847c5a54',
    #   :address => 'mailtrap.io',
    #   :domain => 'mailtrap.io',
    #   :port => '2525',
    #   :authentication => :cram_md5
    # }

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'GBP'
    paypal_options = {
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SECRET']
    }
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end

# config.after_initialize do
#   ActiveMerchant::Billing::Base.mode = :test
#   paypal_options = {
#     login: 'test22323_api1.me.com',
#     password: '3NLBEU6JTXTL7CFX',
#     signature: 'AFcWxV21C7fd0v3bYYYRCpSSRl31AGsFLJIELCKgwNQxVTvKEddfeQMq'
#   }
#   ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
# end

end
