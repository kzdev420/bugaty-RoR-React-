ActiveAdmin.register Continent do

  permit_params %i(name title keywords content description)

  config.sort_order = 'name_asc'

  remove_filter :countries, :regions

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    resource_class.content_columns.each { |col| column col.name.to_sym }
    column 'Countries', sortable: false do |continent|
      link_to 'Countries', admin_continent_countries_path(continent)
    end
    actions
  end
end
