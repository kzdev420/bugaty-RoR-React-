class OrdersController < ApplicationController

  # PAYPAL EXPRESS CHECKOUT

  def express_checkout
    @listing = current_user.listings.find(params[:listing_id])
    @to_be_payed = params[:amount_to_pay].to_f
    @listing.update(amount_to_pay: @to_be_payed)
    set_feature_status(params[:payment_description])

    response = EXPRESS_GATEWAY.setup_purchase((@to_be_payed * 100).to_i,
      ip: request.remote_ip,
      return_url: pp_express_new_url,
      cancel_return_url: root_url,
      currency: "GBP",
      allow_guest_checkout: true,
      items: [{name: "Listing featured options", description: "Listing featured options", quantity: "1", amount: @to_be_payed * 100}]
    )

    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def new
    # @order = Order.new(:express_token => params[:token])
    @listing = current_user.listings.find(params[:id])
    @to_be_payed = @listing.amount_to_pay

    @order = Order.new(:listing_id => @listing.id, :express_token => params[:token])

    if Rails.env.development?
      @order.ip = '178.140.29.72'
    else
      @order.ip = request.remote_ip
    end

    if @order.save
      if @order.purchase((@to_be_payed * 100).to_i)
        sucess_logic
      else
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        render :stripe_new
      end
    else
      flash[:alert] = "Order can't be created"
      render :stripe_new
    end

  end

  # STRIPE CHECKOUT

  def stripe_new
    @listing = current_user.listings.find(params[:id])

    if @listing.featured_cat? && @listing.featured_home? && @listing.urgent?
      flash[:alert] = 'Listing does not require payment.'
      redirect_to listings_path
    end

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Listing not found.'
    redirect_to listings_path
  end

  def stripe_create
    @listing = current_user.listings.find(params[:listing_id])

    @to_be_payed = params[:amount_to_pay]

    currency = $price.currency == '£' ? 'GBP' : 'USD'

    gateway = ActiveMerchant::Billing::StripeGateway.new(login: ENV['STRIPE_SECRET'])
    response = gateway.purchase((@to_be_payed.to_f * 100).to_i, params[:stripe_token], currency: currency)

    if response.success?
      set_feature_status(params[:payment_description])
      sucess_logic
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      render :stripe_new
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private
    # def generate_client_token
    #   Braintree::ClientToken.generate
    # end

    def order_params
      params.permit(:listing_id, :ip, :express_token, :express_payer_id)
    end

    def set_feature_status(description)
      case description
      when 'Featured on homepage'
        @listing.update(featured_home: 1)
      when 'Featured on category'
        @listing.update(featured_cat: 1)
      when 'Urgent'
        @listing.update(urgent: 1)
      end
    end

    def sucess_logic
      # setting the date
      @listing.update_attributes(featured_home_date: Time.now) if @listing.featured_home.present?
      @listing.update_attributes(featured_cat_date: Time.now) if @listing.featured_cat.present?
      @listing.update_attributes(urgent_date: Time.now) if @listing.urgent.present?

      @listing.update_attributes(amount_to_pay: nil, amount_to_pay_currency: nil)

      NewListingMailer.new_payment_to_admin(@listing, @to_be_payed).deliver_later # send email to admin
      NewListingMailer.new_payment_to_user(@listing, @to_be_payed).deliver_later # send email to user
      redirect_to listing_path(@listing), notice: 'Congratulations! Your listing have been paid!'
    end
end
