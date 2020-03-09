class Order < ApplicationRecord
	belongs_to :listing

  #PAYPAL PART
  def purchase(price)
    response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
    # cart.update_attribute(:purchased_at, Time.now) if response.success?
    # Rails.logger.debug("--> #{response.success?} // #{response.info} // #{response.note} // #{response.inspect}")
    response.success?
  end

  def express_token=(token)
    self[:express_token] = token
    if new_record? && !token.blank?
      # you can dump details var if you need more info from buyer
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
    end
  end

  private

  def express_purchase_options
    {
      :ip => ip,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end


end
