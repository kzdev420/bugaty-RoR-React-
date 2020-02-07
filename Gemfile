# frozen_string_literal: true
source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

# Base
gem 'rails', '~> 5.0.0'
gem 'pg'
gem 'mysql2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'therubyracer', platforms: :ruby
gem 'rack-utf8_sanitizer'
gem 'active_model_serializers'

# USER
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2', '~> 0.8.0'
#gem 'google-api-client', require: 'google/api_client'
gem 'devise_lastseenable'
gem "recaptcha",  require: "recaptcha/rails"
gem 'activerecord-session_store'

# Search
# gem 'searchkick'
# gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
# gem 'elasticsearch-rails'
# gem 'bonsai-elasticsearch-rails'

#payments
gem 'activemerchant'
gem 'offsite_payments'
# gem "braintree"
gem 'gon'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'paypal-recurring'

# Styles and template
gem 'bootstrap-sass', '3.4.1'
gem 'bourbon'
gem 'autoprefixer-rails'
gem 'font-awesome-rails'

# Pagination
gem 'will_paginate'
gem 'kaminari'

#  Graphic
gem 'figaro'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick'
gem 'file_validators'
gem 'jquery-fileupload-rails'
gem 'photoswipe-rails'
gem 'dragonfly'
gem 'avatar_magick'
gem "fog-aws"
gem 'open_uri_redirections'
gem 'youtube_addy'
gem 'rinku', :git => 'https://github.com/vmg/rinku.git', :tag => 'v2.0.2'
gem 'video_info', '~> 2.5'
gem 'carrierwave-imageoptimizer', '~> 1.4.0'

# Geo
gem 'geocoder'
gem 'geo_ip'
gem 'country_select'
gem 'city-state'

# admin
gem 'activeadmin', '~> 1.0.0.pre4'
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
gem 'cancancan', '~> 2.0'
gem 'ckeditor'
gem 'tinymce-rails'
gem 'tinymce-rails-imageupload', '4.0.17.beta'

gem 'friendly_id', '~> 5.1.0'
gem 'sitemap_generator'
gem 'canonical-rails', github: 'jumph4x/canonical-rails'
gem 'whenever', require: false
gem 'cindy'
gem 'http'

gem 'webpacker'
gem 'webpacker-react'
gem 'faker'
gem 'aasm'
gem 'api-pagination'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rtask-db-drop-connections', '~> 1.0'
  gem 'silencer'
  gem 'seed_dump'
  gem 'capistrano', require: false
  gem 'capistrano-ssh-doctor', '~> 1.0'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-faster-assets', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-nvm'
  gem 'capistrano-nvm-install'
  gem 'capistrano-yarn'
  gem 'pry-rails'
  gem 'letter_opener'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
