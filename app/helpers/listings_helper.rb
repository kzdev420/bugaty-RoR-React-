require 'rails_rinku'
require 'video_info'
require 'uri'

module ListingsHelper
  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def generate_link(link)
    auto_link(link, :urls, :target => '_blank')
  end

  def generate_meta(key, value)
    "<meta property=\"#{key.sub('seo_', '')}\" content=\"#{value}\" />".html_safe
  end

  def buy_link(listing)
    if current_user
      if listing.available_for_payments? && listing.payment_methods.present? && current_user.open_purchases_for(listing).count.zero?
        link_to 'Buy', '#buy-popup', class: 'popup-with-zoom-anim green'
      else
        ''
      end
    else
      "Please #{link_to 'log in', '#login-popup', class: 'popup-with-move-anim', style: 'color:#369fe0'} to buy"
    end
  end

  def clicks(counter, last_click)
    arrow_class = last_click < 30.days.ago ? 'ico-red-arrow' : 'ico-green-arrow'
    "<i class='ico #{arrow_class}'></i> CLICKS #{counter}"
  end

  def comments_count_str(value)
    value.positive? ? "#{pluralize(value, 'comment')}" : 'no comments yet'
  end

  def embed_small_image(link)
    VideoInfo.provider_api_keys = { youtube: Figaro.env.youtube_api_key, vimeo: Figaro.env.vimeo_api_key }
    video = VideoInfo.new(link)
    video.thumbnail_small
  end

  def embed_video(link)
    VideoInfo.provider_api_keys = { youtube: Figaro.env.youtube_api_key, vimeo: Figaro.env.vimeo_api_key }
    if (valid_url?(link))
      video = VideoInfo.new(link)
      return video.embed_code(iframe_attributes: { width: '100%', height: 315}).html_safe
    else
      ""
    end
  end

  def featured_here?(listing, controller_name)
    if controller_name == 'search'
      listing.featured?
    else
      listing.featured_cat?
    end
  end

  def group_listings(listings)
    grouped_ads = []
    service_ads = []
    listings.each do |listing|
      if listing.service_ad?
        grouped_ads << service_ads if service_ads.count == 0
        service_ads << listing
        service_ads = [] if service_ads.count == 3
      else
        grouped_ads << listing
      end
    end

    grouped_ads.flatten
  end

  def number_to_stars(value)
    (1..5).map do |x|
      if value >= x
        "<i class='ico ico-star'></i>"
      elsif (x - value) <= 0.5
        "<i class='ico ico-star ico-star--half'></i>"
      else
        "<i class='ico ico-star ico-star--blank'></i>"
      end
    end.join
  end

  def offer_link(listing)
    if current_user
      if listing.available_for_payments? && listing.payment_methods.present? && current_user.open_offers_for(listing).count.zero?
        link_to 'Send offer', '#offer-popup', class: 'popup-with-zoom-anim green'
      else
        ''
      end
    else
      "Please #{link_to 'log in', '#login-popup', class: 'popup-with-move-anim', style: 'color:#369fe0'} to make an offer"
    end
  end

  def opening_hours_items
    interval = (0..23).to_a
    int1 = interval.map { |i| "#{i.to_s.rjust(2, '0')}:00" }
    int2 = interval.map { |i| "#{i.to_s.rjust(2, '0')}:30" }
    (int1 + int2).sort
  end

  def payment_method(listing)
    if listing.paypal_id
      'Pay With PayPal'
    elsif listing.subscription_stripe_id
      'Pay With Credit/Debit card'
    else
      'Pay With PayPal'
    end
  end
end
