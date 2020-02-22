class ChangeAdsFormatInListings < ActiveRecord::Migration[5.0]
  def change
	change_column :listings, :urgent, "integer USING CASE urgent WHEN '1' THEN 1 ELSE NULL END"
	change_column :listings, :featured_home, "integer USING CASE featured_home WHEN '1' THEN 1 ELSE NULL END"
	change_column :listings, :featured_cat, "integer USING CASE featured_cat WHEN '1' THEN 1 ELSE NULL END"
	change_column :listings, :featured_all, "integer USING CASE featured_all WHEN '1' THEN 1 ELSE NULL END"
  end
end
