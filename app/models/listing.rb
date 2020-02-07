class Listing < ApplicationRecord
  extend FriendlyId

  before_save :covert_engine

  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  belongs_to :city
  belongs_to :subscription_plan, optional: true

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_many :favorite_listings
  has_many :favorited_by, through: :favorite_listings, source: :user
  has_many :payment_requests

  scope :paused, -> { where('paused = TRUE') }
  scope :active, -> { where('paused = FALSE') }
  scope :not_hidden, -> { where('subscribed_until > ?', Time.current) }

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :reject_blank_photos

  friendly_id :slug_candidates, use: [:slugged, :finders]

  validates :category_id, presence: true
  validates :name, presence: true

  before_validation :downcase_keywords
  before_validation :sanitize_key_features

  geocoded_by :full_address
  after_validation :geocode

  delegate :continent, :country, to: :region

  attr_accessor :agree_to_terms

  def available_for_payments?
    motor_ad? || neighborhood_ad? || pet_ad? || wholesale_ad? || service_ad? || deal_ad?
  end

  def company_displayed=(val)
    if val.to_i == 1
      self.company_display_time = Time.current + 30.days
    end

		super val

		if company_displayed.present? && company_displayed_changed?
			self.amount_to_pay ||= 0
			self.amount_to_pay_currency ||= 'GBP'
			self.amount_to_pay += case company_displayed
			when 30 then $price.company_displayed_30_price.to_d
			when 90 then $price.company_displayed_90_price.to_d
			when 180 then $price.company_displayed_180_price.to_d
			when 360 then $price.company_displayed_365_price.to_d
			else
				0
			end
		end

		company_displayed
	end

  def company_displayed?
    company_displayed.present? && company_display_time.present? && company_display_time > Time.current
  end

  def company_expired?
    company_display_time.present? && company_display_time + 90.days < Time.current
  end

  def company_unpaid?
    company_display_time.present? && company_display_time <= Time.current
  end

  def close_to_expire?
    subscription_active? && subscribed_until <= 5.days.from_now
  end

	def featured_home=(val)
		super val

		if featured_home.present? && featured_home_changed?
			self.amount_to_pay ||= 0
			self.amount_to_pay_currency ||= 'GBP'
			self.amount_to_pay += $price.featured_home_price.to_d
		end

		featured_home
	end

	def featured_cat=(val)
		super val

		if featured_cat.present? && featured_cat_changed?
			self.amount_to_pay ||= 0
			self.amount_to_pay_currency ||= 'GBP'
			self.amount_to_pay += $price.featured_cat_price.to_d
		end

		featured_cat
	end

  def full_address
    city.nil? ? location : [city.name, region.name, country.name].compact.join(',')
  end

  def open?
    opening_hours.reject(&:empty?).map do |hours_item|
      weekday, start_hour, _, end_hour = hours_item.split(' ')
      DateTime.current.between?(
        "#{weekday} #{start_hour}".to_datetime,
        "#{weekday} #{end_hour}".to_datetime
      )
    end.any?
  end

  def region
    city.try(:region) || NullRegion.new
  end

  def should_generate_new_friendly_id?
    seo_title_changed? || super
  end

  def slug_candidates
    [
      :seo_title,
      :name
    ]
  end

  def subscription_active?
    subscribed_until >= Time.current
  end

	def urgent=(val)
		super val

		if urgent.present? && urgent_changed?
			self.amount_to_pay ||= 0
			self.amount_to_pay_currency ||= 'GBP'
			self.amount_to_pay += $price.urgent_price.to_d
		end

		urgent
	end

  def urgent?
    urgent.present? && urgent_date.present? && urgent_date + 30.days > Time.current
  end

  def featured?
    featured_home? || featured_cat?
  end

  def featured_cat?
    featured_cat == 1 && featured_cat_date.present? && featured_cat_date + 30.days > Time.current
  end

  def featured_home?
    featured_home == 1 && featured_home_date.present? && featured_home_date + 30.days > Time.current
  end

  def paid_options_changed?
    (urgent.present? && urgent_changed?) || (featured_home.present? && featured_home_changed?) || (featured_cat.present? && featured_cat_changed?)
  end

  def unpaid?
    amount_to_pay.present? && amount_to_pay > 0 && amount_to_pay_currency.present?
  end

  def payment_description
    dsc = []

    dsc << "Feature on homepage" if featured_home
    dsc << "Feature on category" if featured_cat
    dsc << "Urgent" if urgent

    dsc.join(', ')
  end

  def company_ad?
    category.slug == 'company'
  end

  def content_ad?
    category.slug == 'content'
  end

  def deal_ad?
    category.slug == 'deals'
  end

  def free_stuff_ad?
    category.slug == 'free-stuffs'
  end

  def job_ad?
    category.slug == 'jobs'
  end

  def motor_ad?
    category.slug == 'motors'
  end

  def neighborhood_ad?
    category.slug == 'neighborhood'
  end

  def pet_ad?
    category.slug == 'pets'
  end

  def property_ad?
    category.slug == 'properties'
  end

  def service?
    category.slug == 'services'
  end

  def service_ad?
    category.slug == 'services' || category.slug == 'stuff-for-sale'
  end

  def stuff_ad?
    category.slug == 'stuff-for-sale' || category.slug == 'free-stuffs'
  end

  def stuff_for_sale_ad?
    category.slug == 'stuff-for-sale'
  end

  def wholesale_ad?
    category.slug == 'wholesale'
  end

	def toggle_pause
		update_attribute(:paused, !paused)
	end

	# searchkick
	private
	def covert_engine
		if self.car_engine_size.present?
			puts "===================" + self.car_engine_size.to_s + "==================="
			if Math.log10(self.car_engine_size).to_i + 1 < 3
				self.car_engine_size = self.car_engine_size * 1000
			end
		end
	end

	def reject_blank_photos(attrs)
		attrs[:image].blank?
	end

	def downcase_keywords
		self.keywords = keywords.map(&:downcase) if keywords.is_a? Array
		true
	end

	def sanitize_key_features
		self.key_features = key_features.reject { |val| val.blank? } if key_features.is_a? Array
		true
	end
end

class NullRegion
  def continent
    'Continent is not defined'
  end

  def country
    'Country is not defined'
  end

  def name
    'Region is not defined'
  end
end
