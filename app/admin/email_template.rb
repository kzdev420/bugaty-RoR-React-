ActiveAdmin.register EmailTemplate do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_message_user, :user_confirmation, :user_password_change, :user_reset_password, :user_unlock, :listing_new_admin, :listing_new_payment_admin, :contact_form_admin, :feedback_admin, :listing_message_user, :listing_job_user, :email_global_header, :email_global_footer, :listing_new_payment_user, :report_ad, :admin_email, :listing_new_user, :review_alert, :user_close_account, :expiration_notice, :approval_notice, :deny_notice, :review_reply_alert, :new_payment_request, :new_offer, :payment_request_accepted, :offer_accepted, :payment_request_rejected, :offer_rejected, :new_coupon_code, :trial_period_expiring, :new_subscription

controller do
  def update
    update! do |format|
      format.html {
      	$email_template.reload
      	redirect_to :back
       }
    end
  end
end


# form do |f|
#   f.inputs do
#   	f.input :user_confirmation, :input_html => { :class => 'tinymce' }
#     f.input :user_password_change, :input_html => { :class => 'tinymce' }
#     f.input :user_reset_password, :input_html => { :class => 'tinymce' }
#     f.input :user_unlock, :input_html => { :class => 'tinymce' }
#     f.input :listing_new_admin, :input_html => { :class => 'tinymce' }
#     f.input :listing_new_payment_admin, :input_html => { :class => 'tinymce' }
#     f.input :contact_form_admin, :input_html => { :class => 'tinymce' }
#     f.input :feedback_admin, :input_html => { :class => 'tinymce' }
#     f.input :listing_message_user, :input_html => { :class => 'tinymce' }
#     f.input :listing_job_user, :input_html => { :class => 'tinymce' }
#     f.input :email_global_header, :input_html => { :class => 'tinymce' }
#     f.input :email_global_footer, :input_html => { :class => 'tinymce' }
#     f.input :listing_new_payment_user, :input_html => { :class => 'tinymce' }
#   end
#   f.actions
# end

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
