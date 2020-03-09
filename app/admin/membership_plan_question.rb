ActiveAdmin.register MembershipPlanQuestion do
    menu :parent => "Membership"
    permit_params MembershipPlanQuestion.attribute_names
end 