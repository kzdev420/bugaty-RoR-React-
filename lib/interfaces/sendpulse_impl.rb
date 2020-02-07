require 'sendpulse_api.rb'
def add_subscriber_to_sendpulse_newsletter(email)
  @email = email
  @info = $keychain
  Rails.logger.debug "#{@info.inspect}"
  Rails.logger.debug "#{@info.inspect}"
  sendpulse_api = SendpulseApi.new(@info[:API_CLIENT_ID], @info[:API_CLIENT_SECRET], @info[:API_PROTOCOL], @info[:API_TOKEN])
  sendpulse_api.get_token

  if sendpulse_api.add_emails(@info[:API_NEWSLETTER_ID], {email: @email})[:http_code].to_i == 200
    true
  else
    false
  end
end
