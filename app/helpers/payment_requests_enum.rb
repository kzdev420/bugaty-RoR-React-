module PaymentRequestsEnum
  def request_states
    {
      open: 0,
      accepted: 1,
      rejected: 2
    }
  end

  def request_types
    {
      purchase: 0,
      offer: 1
    }
  end
end
