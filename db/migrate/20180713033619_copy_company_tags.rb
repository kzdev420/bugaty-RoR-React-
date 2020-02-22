class CopyCompanyTags < ActiveRecord::Migration[5.0]
  class Listing < ApplicationRecord
  end

  def up
    Listing.where.not(old_company_tags: nil).find_each do |listing|
      tags = listing.old_company_tags.split(',').map { |tag| tag.strip }
      listing.update(company_tags: tags.first(4))
    end
  end

  def down
    Listing.where.not(company_tags: []).find_each do |listing|
      listing.update(old_company_tags: listing.company_tags.join(','))
    end
  end
end
