ActiveAdmin.register MembershipPlanPortfolio do
    menu :parent => "Membership"
    permit_params MembershipPlanPortfolio.attribute_names
end 