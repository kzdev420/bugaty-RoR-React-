ActiveAdmin.register Price do
  permit_params :featured_home_price, :featured_cat_price, :urgent_price, :currency

  controller do
    def update
      update! do |format|
        format.html do
          $price.reload
          redirect_to :back
        end
      end
    end
  end
end
