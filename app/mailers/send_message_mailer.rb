class SendMessageMailer < ApplicationMailer
	$admin = 'support@bugaty.com'
	$from_name = '"Bugaty Notification" <no-reply@bugaty.com>'

	def new_user_user_email(user, message, sender)
		@user = user
		@message = message
		@sender = sender
		mail(from: $from_name, to: @user.email, subject: "New private message from <#{sender}> for you")
	end

	def new_user_listing_email(listing, message, sender)
		@listing = listing
		@message = message
		@sender = sender
		mail(from: $from_name, to: @listing.user.email, subject: "New message from <#{sender}> for #{@listing.name}")
	end

	def new_user_job_email(listing, message, sender, file, filename)
		@listing = listing
		@message = message
		@sender = sender
		if file.present?
			attachments[filename] = file
		end
		mail(from: $from_name, to: @listing.user.email, subject: "New message from <#{sender}> for job #{@listing.name}")
	end

	def new_report_ad(listing, message, subject)
		@listing = listing
		@message = message
		@subject = subject

		mail(to: $admin, subject: "You got a new report for the listing: #{@listing.name}")
	end

	def contact_form_email(generate_message, attachment = nil)
		@message = generate_message
		attachments[attachment.original_filename] = File.read(attachment.tempfile.path) unless attachment.nil?
		mail(to: $admin, subject: "You have a new message send from contacts page by #{@message[:first_name]}")
	end

	def new_feedback_to_admin(generate_message)
		@message = generate_message
		mail(to: $admin, subject: "You have new feedback for review")
	end

end
