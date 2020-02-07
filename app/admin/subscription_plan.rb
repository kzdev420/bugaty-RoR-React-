ActiveAdmin.register SubscriptionPlan do
  permit_params %i(period price stripe_id)

  form do |f|
    f.inputs 'Subscription Plan Details' do
      f.input :period
      f.input :price
      f.input :stripe_id, as: :string
    end
    f.actions
  end
end
