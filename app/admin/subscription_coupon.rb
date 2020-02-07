ActiveAdmin.register SubscriptionCoupon do
  permit_params %i(name discount)

  actions :index, :new, :create, :destroy

  index do
    selectable_column
    id_column
    column :name
    column :coupon_state
    column :discount
    actions
  end

  filter :name
  filter :discount

  form do |f|
    f.inputs "Coupon Details" do
      f.input :name
      f.input :discount, min: 1
    end
    f.actions
  end

end
