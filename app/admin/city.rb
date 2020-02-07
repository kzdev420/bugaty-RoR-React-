ActiveAdmin.register City do
  belongs_to :region, optional: true
  permit_params %i(name title keywords content description region_id)

  config.sort_order = 'name_asc'

  remove_filter :listings
end
