require 'sendpulse_impl'

class User < ApplicationRecord
  extend FriendlyId

  $keychain = {
                API_CLIENT_ID: ENV['SENDPULSE_API_CLIENT_ID'],
                API_CLIENT_SECRET: ENV['SENDPULSE_API_CLIENT_SECRET'],
                API_NEWSLETTER_ID: ENV['SENDPULSE_API_NEWSLETTER_ID'],
                API_PROTOCOL: 'https',
                API_TOKEN: ''
  }

  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_replies
  has_many :identities, dependent: :destroy

  has_many :favorite_listings, dependent: :destroy
  has_many :favorites, through: :favorite_listings , source: :listing
  has_many :payment_requests
  has_many :coupon_codes
  has_many :blog_comments, dependent: :destroy

  mount_uploader :cover_photo, CoverUploader
  mount_uploader :profile_photo, AvatarUploader
  mount_uploader :cv, CvUploader

  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :lastseenable, :omniauth_providers => [:facebook, :google_oauth2]

  friendly_id :name_with_title, use: [:slugged, :finders]

  after_create :add_to_newsletter, unless: Proc.new { |user| user.provider.nil? }

  validates :new_requests_count, :new_replies_count, numericality: { greater_than_or_equal_to: 0 }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name   # assuming the user model has a name

      user.remote_profile_photo_url = process_uri(auth.info.image) # assuming the user model has an image
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end

  def name_with_title
    [first_name, last_name, title].join(' ')
  end

  def open_offers_for(listing)
    payment_requests.offers.open.where(listing: listing)
  end

  def open_purchases_for(listing)
    payment_requests.purchases.open.where(listing: listing)
  end

  def should_generate_new_friendly_id?
    title_changed? || first_name_changed? || last_name_changed? || super
  end

  def after_confirmation
    add_to_newsletter
  end

  def get_requests_count
    PaymentRequest.where('listing_id IN (?)', listings.pluck(:id)).count
  end

  def sales_count
    PaymentRequest
      .where('listing_id IN (?) AND state = ?', listings.pluck(:id), PaymentRequest.request_states[:accepted])
      .count
  end

  def add_to_newsletter
    sendy = Cindy.new(ENV['SENDY_URL'])
    not_subscribed = 'Email does not exist in list'
    if sendy.subscription_status(ENV['SENDY_LIST_ID'], self.email) == not_subscribed
      sendy.subscribe(ENV['SENDY_LIST_ID'], self.email, self.name_with_title)
    end
  end

  private

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end
end
