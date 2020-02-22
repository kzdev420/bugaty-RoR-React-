class CopyPricesToSubscriptionPlans < ActiveRecord::Migration[5.0]
  class Price < ApplicationRecord
  end

  class SubscriptionPlan < ApplicationRecord
  end

  def up
    price = Price.first

    %i(
      company_displayed_30_price
      company_displayed_90_price
      company_displayed_180_price
      company_displayed_365_price
    ).each do |key|
      day_count = key.to_s.gsub('company_displayed_', '').to_i
      SubscriptionPlan.create(period: "#{day_count} days", price: price.send(key).to_f)
    end
  end

  def down
    price = Price.first
    SubscriptionPlan.find_each do |plan|
      period = plan.period.to_i
      key = "company_displayed_#{period}_price"
      if price.respond_to?(key)
        price.send("#{key.to_sym}=", plan.price)
      end
    end
    price.save

    SubscriptionPlan.delete_all
  end
end
