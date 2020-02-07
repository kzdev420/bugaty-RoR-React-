# require "active_merchant"

# if Rails.env.test? or Rails.env.cucumber? or Rails.env.development?
#   ActiveMerchant::Billing::Base.mode = :test # change to :production for live
# else
#   ActiveMerchant::Billing::Base.mode = :production # change to :production for live
# end
 
# if Rails.env.test?
#  ::EXPRESS_GATEWAY = ActiveMerchant::Billing::BogusGateway.new
# else
#   ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
#     login: ENV['PAYPAL_LOGIN'],
#     password: ENV['PAYPAL_PASSWORD'],
#     signature: ENV['PAYPAL_SECRET']
#   )
# end
