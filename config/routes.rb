Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  scope Rails.env.development? ? 'admin' : 'K4R1vgI5weRchSLK66iA' do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get '/', to: 'admin/dashboard#index'
  end

  post '/tinymce_assets' => 'tinymce_assets#create'

  devise_for :users, :controllers => {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', omniauth_callbacks: "users/omniauth_callbacks"}, :path_names => { :sign_in => 'login' }

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'users/omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'users/omniauth_callbacks#setup'
  end

  match '/404', :to => 'errors#not_found', :via => :all

  post '/users/:id/upload-cv' => "users#upload_cv", as: :upload_cv
  patch '/users/:id/upload-cv' => "users#upload_cv"

  post '/users/:id/set-email-pref' => "users#set_email_preferences", as: :set_email_preferences
  patch '/users/:id/set-email-pref' => "users#set_email_preferences"

  resources :listings do
    put :favorite, on: :member
  end
  post '/users/:id/send-message' => "users#user_message", as: :new_u_message
  patch '/users/:id/send-message' => "users#user_message"

  post '/listing/:id/send-message' => "listings#send_message", as: :new_message
  patch '/listing/:id/send-message' => "listings#send_message"
  post '/listing/:id/send-job-message' => "listings#job_message", as: :new_job
  patch '/listing/:id/send-job-message' => "listings#job_message"
  post '/listing/:id/report-ad' => "listings#report_ad", as: :report_ad
  patch '/listing/:id/report-ad' => "listings#report_ad"
  get '/listing/batch_delete' => 'listings#batch_delete', as: :listings_batch_delete
  get '/listing/batch_pause' => 'listings#batch_pause', as: :listings_batch_pause
  get '/listing/batch_unpause' => 'listings#batch_unpause', as: :listings_batch_unpause
  get '/update_countries', to: 'listings#update_countries'
  get '/update_regions', to: 'listings#update_regions'
  get '/update_cities', to: 'listings#update_cities'

  get '/listing/:id/subscription' => 'subscriptions#new', as: :subscription
  get '/check-promotional-code' => 'subscriptions#check_coupon_code', as: :check_promotional_code
  post '/subscription_checkout' => 'subscriptions#subscription_checkout'
  post '/stripe_webhook' => 'subscriptions#stripe_webhook'
  post '/paypal_subscription' => 'subscriptions#paypal_subscription'
  delete '/subscription/:id' => 'subscriptions#cancel_subscription', as: :cancel_subscription

  post '/listing/:id/add-comment' => "listings#new_comment", as: :new_comment
  post '/listing/:id/reply-comment' => "listings#new_comment_reply", as: :new_comment_reply

  get '/listings/new/:id' => 'listings#new'
  get '/tags/:tag' => 'listings#tag', as: :tag
  resources :payments, only: [:index, :new, :create]
  post '/checkout/:id' => 'orders#express_checkout', as: :express_checkout
  get '/checkout/new/:id' => 'orders#new', as: :pp_express_new

  get '/users/:id/listings' => 'users#user_listings', as: :user_all_listings
  patch '/users/:user_id/listings/:id/toggle_pause' => 'listings#toggle_pause', as: :user_listing_toggle_pause

  get "/checkout-stripe/:id" => 'orders#stripe_new', as: :stripe_checkout
  post "/checkout-stripe-create/:id" => 'orders#stripe_create', as: :stripe_checkout_do
  patch "/checkout-stripe-create/:id" => 'orders#stripe_create'

  get '/redirect-to' => 'redirect#redirect'

  get '/search' => 'search#search', as: :search
  post '/search' => 'search#search'

  resources :categories
  resources :subcategories

  namespace :blog do
    resources :blog_posts, only: [:index, :show], as: :posts, path: :posts do
      resources :blog_comments, only: [:create], as: :comments, path: :comments
    end
  end

  resources :podcasts, only: [:index] do
    collection do
      get '/episodes/:id' => "podcasts#show", as: :episodes
      post '/subscribe/' => "podcasts#subscribe"
    end
  end

  resources :users
  get '/my-favorites/:id' => "users#favorite", as: :my_favorites

  root "statics#index"
  get '/blog' => "statics#blog"
  get '/about' => "statics#about"
  get '/contact' => "statics#contact"
  get '/terms' => "statics#terms"
  get '/privacy' => "statics#privacy"
  # new pages
  get '/how-it-works' => "statics#how_it_works"
  get '/trust-and-safety' => "statics#trust_and_safety"
  get 'sitemap' => 'statics#sitemap'
  post '/subscribe' => "statics#subscribe"
  get '/pages/:page_slug' => 'statics#preview', as: :preview

  post '/contact/send' => "statics#contact_form", as: :contact_form
  patch '/contact/send' => "statics#contact_form"

  get 'support/search' => "support_topics#support_search", as: :support_search
  post 'support/search' => "support_topics#support_search"
  patch 'support/search' => "support_topics#support_search"
  get '/support/:support_topic_slug' => "support_topics#show_category", as: :slugged_support_topic
  get 'support/:support_topic_slug/:support_article_slug' => "support_topics#show_article", as: :slugged_support_article
  get '/support/:id' => "support_topics#show_category", as: :support_topic
  get 'support/:id/:article' => "support_topics#show_article", as: :support_article

  get '/feedbacks' => "feedbacks#index"
  post '/feedbacks/new' => "feedbacks#create", as: :new_feedback
  patch '/feedbacks/new' => "feedbacks#create"

  get '/start-selling' => 'statics#start_selling', as: :start_selling
  resources :continents, only: [:index, :show]
  get '/countries/:id', to: 'countries#show', as: :country

  resources :payment_requests, only: [:create, :edit, :update]
  get 'payment_requests/incoming' => 'payment_requests#incoming', as: :incoming_requests
  get 'payment_requests/sent' => 'payment_requests#sent', as: :sent_requests
  get '/check_coupon_code' => 'payment_requests#check_coupon_code', as: :check_coupon_code
  get '/payment_requests/batch_delete' => 'payment_requests#batch_delete', as: :payment_requests_batch_delete

  resources :coupon_codes, only: [:index, :create]

  get '/:category_slug' => 'categories#show', as: :slugged_category
  get '/:category_slug/:subcategory_slug' => 'subcategories#show', as: :slugged_subcategory

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
