class Sitemap
  attr_accessor :links

  def initialize
    links = []
    about_links = []
    about_links << {name: 'Search', url: '/search'}
    about_links << {name: 'Contact', url: '/contact'}
    about_links << {name: 'Terms & Conditions', url: '/terms'}
    about_links << {name: 'Privacy policy', url: '/privacy'}
    about_links << {name: 'How it works', url: '/how-it-works'}
    about_links << {name: 'Trust & Safety', url: '/trust-and-safety'}
    links << {name: 'About us', url: '/about', children: about_links}
    Category.order(:name).each do |category|
      subcategory_links = []
      Subcategory.where(category: category).each do |subcategory|
        subcategory_links << {
          name: subcategory.name,
          url: "/#{category.slug}/#{subcategory.slug}"
        }
      end
      links << {
        name: category.name,
        url: "/#{category.slug}",
        children: subcategory_links
      }
    end

    Continent.find_each do |continent|
      country_links = continent.countries.order(:name).map do |country|
        {name: "#{country.name} classifieds ads",
         url: "/countries/#{country.slug}"}
      end
      unless country_links.empty?
        links << {
          name: "#{continent.name} Classifieds Ads",
          url: "/continents/#{continent.slug}",
          children: country_links
        }
      end
    end
    @links = links
  end

  def count_members
    @links.each do |item|
      item[:weight] = hash_size(item)
    end
  end

  private

  def hash_size(obj)
    if obj.include?(:children)
      obj[:children].inject(0) { |sum, child| sum += hash_size(child) } + 1
    else
      1
    end
  end
end
