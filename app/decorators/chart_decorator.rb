class ChartDecorator < Draper::Decorator
  delegate_all
  
  def prices_str
    if prices_are_eq?
      return current_prices_str 
    else 
      return all_prices_str
    end
  end
  
  def current_prices_str
    return nil if model.nil?
    gen_prices_str( :dayof_price )
  end

  def all_prices_str
    ["<strong>Adv</strong> ", gen_prices_str( :presale_price  ), 
     "<br/><strong>Day Of</strong> ", gen_prices_str( :dayof_price )]
     .join('')
     .strip
     .html_safe
  end
  
private 
  
  def gen_prices_str(price_name)
    return nil if model.nil?
  
    str = model.sections
               .includes(:dayof_price, :presale_price)
               .seatable
               .order('label DESC')
               .reduce('') do |memo, section|
      base_price = "%.2f" % section.send(price_name).base
      base_price = remove_zeros(base_price) # convert 10.00 to 10
      memo += "#{section.label} $#{base_price} / " 
    end
  
    str[0..-3] # without trailing slash
  
  end
  
  def remove_zeros(str)
    str[-3,3] == '.00' ? str[0..-4] : str
  end
  
  def prices_are_eq?
    presale_prices_arr == dayof_prices_arr
  end
  
  def presale_prices_arr
    model.sections.map{|s| s.presale_price.base}
  end
  
  def dayof_prices_arr
    model.sections.map{|s| s.dayof_price.base}
  end
end