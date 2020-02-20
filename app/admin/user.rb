ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params %i(confirmed_at first_name last_name email password phone
                   language location last_active profile_photo cover_photo title
                   keywords description receive_new_companies receive_new_ads
                   receive_updates nomoderation provider uid cv)

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    f.inputs 'User Details' do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :language
      f.input :location
      f.input :profile_photo
      f.input :cover_photo
      f.input :last_active
      f.input :title
      f.input :keywords
      f.input :description
      f.input :email, input_html: { autocomplete: 'off' }
      f.input :nomoderation, as: :boolean
      f.input :last_active
      f.input :receive_new_companies
      f.input :receive_new_ads
      f.input :receive_updates
      f.input :created_at
      f.input :updated_at
      f.input :last_seen
      f.input :provider
      f.input :uid
      f.input :cv
    end

    f.actions
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end
end
