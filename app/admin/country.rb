ActiveAdmin.register Country do
  belongs_to :continent, optional: true, finder: :find_by_slug
  permit_params %i(name title keywords content description continent_id)

  config.sort_order = 'name_asc'

  remove_filter :regions, :cities, :listings

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    resource_class.content_columns.each { |col| column col.name.to_sym }
    column 'Regions', sortable: false do |country|
      link_to 'Regions', admin_country_regions_path(country)
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
      row :continent do |country|
        link_to country.continent.name, admin_continent_path(country.continent)
      end
      row :links do |region|
        link_to 'Regions', admin_country_regions_path(country)
      end
    end
    active_admin_comments
  end
end
