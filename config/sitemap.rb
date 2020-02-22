SitemapGenerator::Sitemap.default_host = "http://www.bugaty.com"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  add '/search'
  add '/about'
  add '/contact'
  add '/terms'
  add '/privacy'
  add '/how-it-works'
  add '/trust-and-safety'
  add '/contact/send'

  Category.order(:name).each do |category|
    add "/#{category.slug}"
  end

  Subcategory.all.each do |subcategory|
    add slugged_subcategory_path(subcategory.category.slug, subcategory.slug)
  end

  User.order(:last_name).find_each do |user|
    add user_path(user), lastmod: user.updated_at
  end

  Country.order(:name).find_each do |country|
    add country_path(country)
  end
end
