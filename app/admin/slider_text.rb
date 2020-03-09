ActiveAdmin.register SliderText do
  menu :parent => "Homepage"
  permit_params :header, :slogan
end
