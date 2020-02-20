ActiveAdmin.register Category do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params %i(name title keywords description content serial_number payable)

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  controller do
    def destroy
      destroy! do |format|
        format.html {
          $all_cats.reload
          redirect_to collection_path
        }
      end
    end

    def create
      create! do |format|
        format.html {
          $all_cats.reload
          redirect_to collection_path
        }
      end
    end

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def update
      update! do |format|
        format.html {
          $all_cats.reload
          redirect_to :back
        }
      end
    end
  end
end
