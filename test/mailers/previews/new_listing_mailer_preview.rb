# Preview all emails at http://localhost:3000/rails/mailers/new_listing_mailer
class NewListingMailerPreview < ActionMailer::Preview

@admin_mail = 'xs290@Me.com'


  def new_listing_mail_to_admin_preview
		NewListingMailer.new_listing_mail_to_admin(Listing.last)
  end

end
