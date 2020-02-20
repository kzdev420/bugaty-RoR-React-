module ApplicationHelper

  def ads_list_title(category, listings)
    "#{pluralize(listings, 'listing').upcase} IN <span>#{category.name}</span> CLASSIFIEDS ADS".html_safe
  end

  def category_collection
    cats = $all_cats.map { |cat| [cat.name, cat.id] }
    cats.sort_by { |name, id| name }
  end

  def expiration_message(value)
    if value < Date.current
      value.strftime("VALID UNTIL %d/%m/%Y")
    else
      value.strftime("EXPIRED %d/%m/%Y")
    end
  end

  def full_title(page_title='')
    base_title = $template.page_title.presence || 'Bugaty.com – Post free ads | Uk’s Best Classified Website, Buy & Sell!'
    page_title.empty? ? base_title : page_title
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
      User
  end

  # checks if the listing was favourited
  def is_favorited?(lid)
    if current_user
      if FavoriteListing.find_by(user_id: current_user.id, listing_id: lid) == nil
        return true
      else
        return false
      end
    end
  end

  def average_value(arr)
    arr.size.positive? ? arr.sum / arr.size.to_f : 0
  end

  def comments_count_string(user)
    comments_count = user.comments.count
    comments_count.positive? ? "(#{pluralize(comments_count, 'review')})" : '(no reviews set)'
  end

  def get_listing_rating(id)
    rates = id.comments.pluck(:rating).map(&:to_i)
    average_value(rates)
  end

  def get_listings_rating_for(user)
    rates = []
    user.listings.each do |listing|
      rates += listing.comments.pluck(:rating).map(&:to_i)
    end
    average_value(rates)
  end

  def review_count_string(owner)
    review_count = if owner.class.name == 'Listing'
                     owner.comments_count
                   else
                     owner.listings.pluck(:comments_count).sum
                   end
    review_count.positive? ? "(#{pluralize(review_count, 'review')})" : '(no reviews set)'
  end

  def pagination_link
    if params[:pagination_select].present?
      will_paginate @listings, params: {pagination_select: params[:pagination_select]}
    else
      will_paginate @listings
    end
  end

  #render erb
  def render_erb_text(text, args={})
     b = binding
     template = ERB.new(text, 0, "%<>")
     template.result(b)
  end

  def listing_price(price)
    if price.nil?
      ''
    else
      if price.floor == price
        price.to_i.to_s
      else
        "%.2f" % price
      end
    end
  end

  def shorter_time_ago_in_words t
    str = time_ago_in_words(t)
    if str.start_with? 'about '
      str[6..-1]
    else
      str
    end
  end

  def discount_amount(amount, code)
    coupon_code = current_user.coupon_codes.not_expired.where(name: code).take
    coupon_code.nil? ? 0 : amount / 100 * coupon_code.discount
  end

  def total_amount(price, delivery_cost, discount_code)
    total = price
    total += delivery_cost if delivery_cost.present?
    total -= discount_amount(total, discount_code) if discount_code.present?
    total.to_s
  end

  def currency_sign(currency_name)
    symbol = case currency_name
             when 'Pound' then "\u00A3"
             when '£' then "\u00A3"
             when 'Dollar' then "\u0024"
             when 'Euro' then "\u20AC"
             else
               "\u00A3"
             end
    symbol.force_encoding('utf-8')
  end
end
