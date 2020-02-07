class ApplicationMailer < ActionMailer::Base

  @admin_email = 'support@bugaty.com'

  default from: 'Bugaty <no-reply@bugaty.com>'
  layout 'mailer'
end
