desc 'Check featured/urgent dates & reset corresponding fields'

task :check_payment_dates => :environment do
  Listing.where(urgent: 1).find_each do |listing|
    if listing.urgent_date.nil? || (listing.urgent_date + 30.days) < Time.current
      listing.update_attributes(
        urgent: nil, urgent_date: nil, amount_to_pay: nil
      )
    end
  end
  Listing.where(featured_home: 1).find_each do |listing|
    if listing.featured_home_date.nil? || (listing.featured_home_date + 30.days) < Time.current
      listing.update_attributes(
        featured_home: nil, featured_home_date: nil, amount_to_pay: nil
      )
    end
  end
  Listing.where(featured_cat: 1).find_each do |listing|
    if listing.featured_cat_date.nil? || (listing.featured_cat_date + 30.days) < Time.current
      listing.update_attributes(
        featured_cat: nil, featured_cat_date: nil, amount_to_pay: nil
      )
    end
  end
end
