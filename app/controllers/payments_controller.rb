class PaymentsController < ApplicationController
  def index
  	@payments = Payment.all
  end

  def new
  	@payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      if @payment.process
      	puts "====== PAYMENT PROCESSING IN CONTROLLER ======"
        redirect_to root_path, notice: "The user has been successfully charged." and return
      end
    end
    render 'new'
  end

private
  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount)
  end

end
