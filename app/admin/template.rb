ActiveAdmin.register Template do

  actions :all, :except => [:create, :new, :destroy]

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params %i(facebook_link twitter_link googleplus_link youtube_link
                   mainpage_slider about_slider about_text contact_details
                   feedback_slider feedback_text support_slider footer_text
                   safety_text mainpage_benefits mainpage_options mainpage_featured_in
                   global_footer how_it_works_text trust_and_safety_text terms
                   privacy page_description start_selling page_title page_keywords)

controller do
  def update
    update! do |format|
      format.html {
      	$template.reload
      	redirect_to :back
       }
    end
  end
end

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
