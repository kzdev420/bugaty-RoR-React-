ActiveAdmin.register Feedback do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :published, :image, :first_name, :last_name, :company, :position, :country, :content, :user_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    f.inputs 'Feedback' do
      f.input :user_id, :as => :string
      f.input :first_name, :as => :string
      f.input :last_name, :as => :string
      f.input :company, :as => :string
      f.input :position, :as => :string
      f.input :country, :as => :string
      f.input :content, :as => :string
      f.input :published, :as => :boolean
    end
    f.actions
  end



end
