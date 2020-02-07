class Payment < ApplicationRecord
  require 'active_merchant/billing/rails'

  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_security_code, presence: true
  validates :credit_card_number, presence: true
  validates :expiration_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :expiration_year, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  validate :valid_card

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      number:              credit_card_number,
      verification_value:  card_security_code,
      month:               expiration_month,
      year:                expiration_year,
      first_name:          first_name,
      last_name:           last_name
    )
  end

  def valid_card
    puts "====== VALIDATING CARD ======"
    if !credit_card.valid?
      puts "====== CARD NOT VALID ======"
      errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
      false
    else
      puts "====== CARD VALID ======"
      true
    end
  end

  def process
    if valid_card
      puts "====== SENDING GATEWAY RESPONCE ======"
      response = GATEWAY.purchase(amount * 100, credit_card, :ip => "127.0.0.1")
      if response.success?
        puts "====== GOT ANSWER ======"
        transaction = GATEWAY.capture(amount * 100, response.authorization)
        if !transaction.success?
          puts "====== CARD DIDNT PASS ======"
          errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
          false
        end
        puts "====== PAYMENT DONE, UPDATING DATABASE ======"
        update_columns({authorization_code: transaction.authorization, success: true})
        true
      else
        puts "====== NO ANSWER ======"
        errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
  end
end
