ActiveAdmin.register MyShopSection do
    menu :parent => "Homepage"
    permit_params MyShopSection.attribute_names
end 