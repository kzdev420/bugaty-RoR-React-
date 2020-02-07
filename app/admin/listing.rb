ActiveAdmin.register Listing do

  include ActiveModel::Dirty

  after_save do |listing|
    if listing.published == 2
        NewListingMailer.listing_approval_notice(@listing).deliver_later
    elsif listing.published == 3
        NewListingMailer.listing_deny_notice(@listing).deliver_later
    end
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :user_id, :name, :category_id, :subcategory_id,
    :brand, :condition, :location, :description, :seo_keywords,
    :seo_description, :seo_title, :delivery_time, :delivery_cost, :price,
    :price_per, :salary_per, :price_per_property, :car_make, :car_model,
    :car_reg_year, :car_gearbox, :car_mileage, :car_engine_size,
    :car_fuel_type, :car_body_type, :car_color, :job_type, :property_type,
    :property_size_rooms, :property_size_meters, :property_size_feets,
    :property_date_available, :video_url, :pet_type, :pick_up_only, :published,
    :featured_home, :featured_cat, :urgent, :featured_home_date,
    :featured_cat_date, :urgent_date, :company_displayed,
    :company_display_time, :price_open_to_offers, :price_per, :salary_per,
    :price_per_property, :wholesale_price, :retail_price, :wholesale_moq,
    :sale_price, :company_country, :company_phone, :company_website, :company_facebook,
    :company_twitter, :company_googleplus, :company_instagram, :company_linkedin,
    :company_youtube, :paused, :subscribed_until, :deal_url, :deal_expire_time, :deal_coupon
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    tabs do
      tab 'Details' do
        f.inputs 'Details', :user_id, :name, :category_id, :subcategory_id,
        :brand, :condition, :location, :seo_keywords,
        :seo_description, :seo_title, :delivery_time, :delivery_cost, :price,
        :price_per, :salary_per, :price_per_property, :car_make, :car_model,
        :car_reg_year, :car_gearbox, :car_mileage, :car_engine_size,
        :car_fuel_type, :car_body_type, :car_color, :job_type, :property_type,
        :property_size_rooms, :property_size_meters, :property_size_feets,
        :property_date_available, :video_url, :pet_type, :pick_up_only, :published,
        :featured_home, :featured_cat, :urgent, :featured_home_date,
        :featured_cat_date, :urgent_date, :company_displayed,
        :company_display_time, :price_open_to_offers, :price_per, :salary_per,
        :price_per_property, :wholesale_price, :retail_price, :wholesale_moq,
        :sale_price, :company_country, :company_phone, :company_website, :company_facebook,
        :company_twitter, :company_googleplus, :company_instagram, :company_linkedin,
        :company_youtube, :paused, :subscribed_until, :deal_url, :deal_expire_time, :deal_coupon
      end
      tab 'Description' do
        f.inputs 'Description' do
          f.input :description, as: :text, input_html: { class: 'tinymce' }
        end
      end
    end
    f.actions
  end

def display_name
  return self.id.to_s + '-' + self.email
end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

end
