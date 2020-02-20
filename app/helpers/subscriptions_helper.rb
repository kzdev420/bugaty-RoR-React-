module SubscriptionsHelper
  def features_array(listing)
    features = []
    features << ["Featured on homepage - #{currency_sign($price.currency)}#{$price.featured_home_price}"] unless listing.featured_home?
    features << ["Featured on category - #{currency_sign($price.currency)}#{$price.featured_cat_price}"] unless listing.featured_cat?
    features << ["Urgent - #{currency_sign($price.currency)}#{$price.urgent_price}"] unless listing.urgent?

    features
  end

  def subscription_plans_array
    SubscriptionPlan.all.order(:id).map do |plan|
      ["#{currency_sign($price.currency)}#{plan.price} #{plan.period}", plan.id]
    end
  end
end
