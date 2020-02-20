class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.where(published: true)
    @page = Page.friendly.find('feedbacks')
  end

	def create
		respond_to do |format|
			if current_user
				if current_user.profile_photo.present?
					@feedback = Feedback.new(feedback_params.merge(:user_id => current_user.id, :image => current_user.profile_photo.small))
				else
					@feedback = Feedback.new(feedback_params.merge(:user_id => current_user.id))
				end
			else
				@feedback = Feedback.new(feedback_params)
			end

		    if @feedback[:content].length > 10 && @feedback[:first_name].length > 3 && @feedback[:last_name].length > 3 && @feedback[:company].length > 3 && @feedback[:position].length > 2 && @feedback[:country].length > 3
		      @feedback.save
		      SendMessageMailer.new_feedback_to_admin(@feedback).deliver_later # send email to admin
		      format.json { render json: nil, status: :ok }
		      format.html {
		      	flash[:info] = "Thank you! Your feedback was sucessfully send for review."
		      	redirect_to :back
		      }
		    else
		      format.json { render json: nil, status: 422 }
		      format.html {
		      	flash[:error] = "Sorry, something went wrong. Please try again"
		      	redirect_to :back
		      }
		    end
		end

	end

	private

    def feedback_params
      params.require(:feedback).permit(
        :first_name, :last_name, :image, :company, :position, :country, :content, :user_id
        )
    end

end
