class NewListingMailer < ApplicationMailer

	def new_listing_mail_to_admin(listing)
		@admin_email = 'support@bugaty.com'
		@listing = listing
		mail(to: @admin_email, subject: 'New listing was created')
	end

	def new_listing_mail_to_user(listing)
		@listing = listing
		mail(to: @listing.user.email, subject: 'Your listing was created')
	end

	def listing_approval_notice(listing)
		@listing = listing
		mail(to: @listing.user.email, subject: 'Your listing was approved')
	end

	def listing_deny_notice(listing)
		@listing = listing
		mail(to: @listing.user.email, subject: 'Your listing was not approved')
	end

	def new_comment_listing(listing, comment)
		@listing = listing
		@comment = comment
		mail(to: @listing.user.email, subject: 'You have an new review for your listing')
	end

	def new_comment_reply_listing(listing, comment)
		@listing = listing
		@comment = comment
		mail(to: @comment.comment.user.email, subject: 'You have an new reply for your review')
	end

	def new_payment_to_admin(listing, amount)
		@admin_email = 'support@bugaty.com'
		@listing = listing
		@amount = amount
		mail(to: @admin_email, subject: 'New listing payment')
	end


	def new_payment_to_user(listing, amount)
		@user_email = listing.user.email
		@listing = listing
		@amount = amount
		mail(to: @user_email, subject: 'New listing payment')
	end

end
