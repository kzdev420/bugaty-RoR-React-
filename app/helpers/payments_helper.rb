module PaymentsHelper
  def months
    (1..12).collect{|n| ["#{n} - #{Date::MONTHNAMES[n]}", n]}
  end

  def years
    (Time.now.year..Time.now.year+15)
  end
end
