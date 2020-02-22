class SetOneMonthForFreeForAllListings < ActiveRecord::Migration[5.0]
  class Listing < ApplicationRecord
  end

  def up
    Listing.where(subscribed_until: nil).find_each do |listing|
      listing.update(subscribed_until: 1.month.from_now)
    end
  end

  def down
  end
end
