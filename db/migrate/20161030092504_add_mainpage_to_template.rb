class AddMainpageToTemplate < ActiveRecord::Migration[5.0]
  def change
  	add_column :templates, :mainpage_benefits, :text
	add_column :templates, :mainpage_options, :text
	add_column :templates, :mainpage_featured_in, :text
	add_column :templates, :global_footer, :text
  end
end
