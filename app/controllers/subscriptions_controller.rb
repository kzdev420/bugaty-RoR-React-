class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:stripe_checkout, :stripe_webhook]
  skip_before_action :verify_authenticity_token, only: [:stripe_webhook]

  def new
    @listing = Listing.friendly.find(params[:id]) || current_user.listings.last
    @subscription_plan = @listing.subscription_plan || SubscriptionPlan.first
    if params[:PayerID]
      @subscription_plan = SubscriptionPlan.find(params[:plan_id])
      @paypal_customer_token = params[:PayerID]
      @paypal_payment_token = params[:token]
      @total_amount = subscription_price(@subscription_plan)
      @coupon_id = params[:coupon_id]

      render :confirm
    else
      render :new
    end
  end

  def check_coupon_code
    coupon_code = SubscriptionCoupon.not_used.find_by(name: params[:q])
    discount_percentage = coupon_code.try(:discount)

    discount_percentage ||= 0

    render json: { discount: discount_percentage.to_f, coupon: coupon_code.try(:stripe_id) }
  end

  def paypal_checkout
    plan = SubscriptionPlan.find(params[:plan_id])
    price_with_discount = subscription_price(plan)
    listing = Listing.find(params[:listing_id])

    options = { id: listing.id, plan_id: plan.id }
    options.merge!(coupon_id: params[:coupon_id]) if params[:coupon_id].present?

    paypal_options = {
      return_url: subscription_url(options),
      cancel_url: root_url,
      description: "Listing subscription (GBP #{plan.price} / #{plan.period})",
      amount: price_with_discount,
      currency: 'GBP'
    }

    ppr = PayPal::Recurring.new(paypal_options)
    response = ppr.checkout
    if response.valid?
      redirect_to response.checkout_url
    else
      raise response.errors.inspect
    end
  end

  def paypal_subscription
    plan = SubscriptionPlan.find(params[:plan_id])
    listing = Listing.find(params[:listing_id])
    price_with_discount = subscription_price(plan)

    plan_period = plan.period.gsub('-', '').strip
    case plan_period
    when '90 days'
      period = :monthly
      frequency = 3
    when '180 days'
      period = :monthly
      frequency = 6
    when '365 days'
      period = :yearly
      frequency = 1
    else
      period = :monthly
      frequency = 1
    end

    paypal_options = {
      token: params[:paypal_payment_token],
      payer_id: params[:paypal_customer_token],
      description: "Listing subscription (GBP #{plan.price} / #{plan.period})",
      amount: price_with_discount,
      currency: 'GBP'
    }

    if params[:coupon_id].present?
      paypal_options.merge!(trial_period: period, trial_length: 1, trial_frequency: frequency, trial_amount: price_with_discount)
    end

    ppr = PayPal::Recurring.new(paypal_options)
    response = ppr.request_payment
    if response.errors.present?
      raise response.errors.inspect
    end

    start_period = listing.subscribed_until if listing.subscription_active?
    start_period ||= Time.current
    paypal_options[:amount] = plan.price
    paypal_options.merge!(period: period, frequency: frequency, start_at: start_period)

    ppr = PayPal::Recurring.new(paypal_options)
    response = ppr.create_recurring_profile
    if response.errors.present?
      raise response.errors.inspect
    else
      cancel_old_subscriptions(listing, :stripe)
      cancel_old_subscriptions(listing, :paypal)

      end_period = start_period + plan_period.to_i.days

      # log_path = [Rails.root, 'log', 'paypal.log'].join('/')
      # open(log_path, 'a') do |f|
      #   f.puts('New PayPal subscription')
      #   f.puts("Listing ID: #{listing.id}")
      #   f.puts("Plan ID: #{plan.id}")
      #   f.puts("Start of period: #{start_period}")
      #   f.puts("End of period: #{end_period}")
      #   f.puts("PayPal ID: #{response.profile_id}")
      #   f.puts("Coupon ID: #{params[:coupon_id]}")
      #   f.puts("First payment amount: #{paypal_options[:trial_amount]}")
      #   f.puts('-----------------------------------')
      # end

      listing.update(paypal_id: response.profile_id, subscribed_until: end_period, subscription_plan: plan)

      RemindMailer.new_subscription(listing).deliver_later

      flash[:notice] = 'Successfully created a charge'
      redirect_to listing_path(listing)
    end
  end

  # Stripe doesn't allow to change subscription plan if charge interval is different
  # So if subscription exists and user changes the subscription plan
  # - cancel current subscription at period end
  # - create new subscription
  def stripe_checkout
    plan = SubscriptionPlan.find(params[:plan_id])
    stripe_plan = Stripe::Plan.retrieve(plan.stripe_id)
    listing = Listing.find(params[:listing_id])
    user = listing.user

    customer = retrieve_or_create_customer(user)

    options = { customer: customer.id, items: [{ plan: stripe_plan.id }], metadata: { listing: listing.id } }
    options.merge!(coupon: params[:coupon_id]) unless params[:coupon_id].empty?
    if listing.subscription_stripe_id && listing.subscription_plan.id == params[:plan_id]
      subscription = Stripe::Subscription.retrieve(listing.subscription_stripe_id)
      subscription.save(options)
    else
      if listing.subscription_stripe_id
        subscription = Stripe::Subscription.retrieve(listing.subscription_stripe_id)
        subscription.cancel_at_period_end = true
        subscription.delete
      end

      if listing.subscribed_until > DateTime.current
        options.merge!(trial_end: listing.subscribed_until.to_i)
      end
      Stripe::Subscription.create(options)
    end

    RemindMailer.new_subscription(listing).deliver_later

    flash[:notice] = 'Successfully created a charge'
    redirect_to listing_path(listing)
  end

  def subscription_checkout
    if params[:stripe_token] && params[:stripe_token].size.positive?
      stripe_checkout
    else
      paypal_checkout
    end
  end

  def stripe_webhook
    begin
      event_json = JSON.parse(request.body.read)
      event_object = event_json['data']['object']
      #refer event types here https://stripe.com/docs/api#event_types
      case event_json['type']
        when 'invoice.payment_succeeded'
          create_subscription(event_object)
        when 'invoice.payment_failed'
          # handle_failure_invoice event_object
        when 'charge.failed'
          # handle_failure_charge event_object
        when 'customer.subscription.deleted'
          delete_subscription(event_object)
        when 'customer.subscription.updated'
          update_subscription(event_object)
      end
    rescue Exception => ex
      render :json => {:status => 422, :error => "Webhook call failed"}
      return
    end
    render :json => {:status => 200}
  end

  def cancel_subscription
    listing = Listing.find(params[:id])

    if listing.paypal_id
      ppr = PayPal::Recurring.new(profile_id: listing.paypal_id)
      ppr.cancel
    else
      subscription = Stripe::Subscription.retrieve(listing.subscription_stripe_id)
      subscription.cancel_at_period_end = true
      subscription.delete
    end

    listing.update(paypal_id: nil, subscription_plan: nil, subscription_stripe_id: nil)

    redirect_to user_all_listings_path(listing.user), notice: 'Your subscription was cancelled'
  end

private

  def cancel_old_subscriptions(listing, type)
    if type == :stripe && listing.subscription_stripe_id
      subscription = Stripe::Subscription.retrieve(listing.subscription_stripe_id)
      subscription.cancel_at_period_end = true
      subscription.delete
    elsif type == :paypal && listing.paypal_id
      ppr = PayPal::Recurring.new(profile_id: listing.paypal_id)
      ppr.cancel
    end
  end

  def create_subscription(obj)
    user = User.find_by(stripe_id: obj['customer'])
    return unless user

    data = obj['lines']['data'].first
    listing = user.listings.find(data['metadata']['listing'])

    return unless listing

    cancel_old_subscriptions(listing, :paypal)
    listing.update(
      subscription_plan: SubscriptionPlan.find_by(stripe_id: data['plan']['id']),
      subscription_stripe_id: obj['subscription'],
      subscribed_until: Time.at(data['period']['end'])
    )
  end

  def delete_subscription
    listing = Listing.find_by(subscription_stripe_id: obj['id'])
    options = { subscription_stripe_id: nil }
    options.merge!(subscription_plan: nil) unless listing.paypal_id
    listing.update(options)
  end

  def update_subscription(obj)
    listing = Listing.find_by(stripe_id: obj['id'])
    return unless listing

    listing.update(
      subscription_plan: SubscriptionPlan.find_by(stripe_id: obj['plan']['id']),
      subscribed_until: Time.at(obj['current_period_end'])
    )
  end

  def retrieve_or_create_customer(user)
    return Stripe::Customer.retrieve(user.stripe_id) if user.stripe_id?

    customer = Stripe::Customer.create(
                 :description => "Customer with #{user.email}",
                 :source => params[:stripe_token],
                 :email => user.email
               )
    user.update(stripe_id: customer.id)

    customer
  end

  def subscription_price(plan)
    return plan.price unless params[:coupon_id].present?

    coupon_code = SubscriptionCoupon.not_used.find_by(stripe_id: params[:coupon_id])
    discount_percentage = coupon_code.try(:discount) || 0
    plan.price - plan.price * discount_percentage / 100
  end
end
