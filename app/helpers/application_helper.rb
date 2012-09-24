module ApplicationHelper
  require 'uri'
  def qr(text, options = {})
    options[:image] ||= false
    encoded_text = URI.encode(text)
    img_path = "https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl=#{encoded_text}&chld=L|1&choe=UTF-8"

    options[:image] == false ? img_path : image_tag(img_path)
    
  end
end
