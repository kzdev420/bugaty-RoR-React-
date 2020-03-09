ActiveAdmin.register Region do
  belongs_to :country, optional: true, finder: :find_by_slug
  permit_params %i(name title keywords content description country_id)

  config.sort_order = 'name_asc'

  remove_filter :cities, :listings

  index do
    selectable_column
    id_column
    resource_class.content_columns.each { |col| column col.name.to_sym }
    column 'Cities', sortable: false do |region|
      link_to 'Cities', admin_region_cities_path(region)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :title
      row :keywords
      row :content
      row :description
      row :country do |region|
        link_to region.country.name, admin_country_path(region.country)
      end
      row :links do |region|
        link_to 'Cities', admin_region_cities_path(region)
      end
    end
    active_admin_comments
  end
end
