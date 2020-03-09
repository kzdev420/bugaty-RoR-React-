class MembershipsController < ApplicationController
    before_action :authenticate_user! ,except: [:index, :plans]
    def index
        @first = MembershipLandingpageFirstSection.all
        @second = MembershipLandingpageSecondSection.all
        @third = MembershipLandingpageThirdSection.all
        @fourth = MembershipLandingpageFourthSection.all
        @fifth = MembershipLandingpageFifthSection.all
        @sixth = MembershipLandingpageSixthSection.all
    end
    
    def show
    end

    def plans
        @testimonial = MembershipPlanTestimonial.all
        @question = MembershipPlanQuestion.all
        @portfolio = MembershipPlanPortfolio.all
    end

    def change_plan
        @cancel_text = MembershipCancelText.all
    end

    def pay
        @listing = current_user.listings.find(params[:id])

        if @listing.featured_cat? && @listing.featured_home? && @listing.urgent?
        flash[:alert] = 'Listing does not require payment.'
        redirect_to listings_path
        end

    rescue ActiveRecord::RecordNotFound
        flash[:alert] = 'Listing not found.'
        redirect_to listings_path
    end
end
