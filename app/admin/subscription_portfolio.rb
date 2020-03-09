ActiveAdmin.register SubscriptionPortfolio do
    menu :parent => "Subscription"
    permit_params SubscriptionPortfolio.attribute_names
end 