class CopyCompanyDisplayTimeToSubscribedUntil < ActiveRecord::Migration[5.0]
  class Listing < ApplicationRecord
  end

  def up
    Listing.where(category_id: 1).find_each do |listing|
      listing.update(subscribed_until: listing.company_display_time)
    end
  end

  def down
    Listing.where(category_id: 1).find_each do |listing|
      listing.update(company_display_time: listing.subscribed_until)
    end
  end
end
