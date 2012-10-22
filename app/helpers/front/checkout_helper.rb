module Front::CheckoutHelper
  def attr_or_nil(sym)
    flash[:checkout] ? flash[:checkout].send(sym) : nil
  end
end
