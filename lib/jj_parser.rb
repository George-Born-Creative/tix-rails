require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'ostruct'

class JJParser
  
  def initialize(url)
    @url = url
    @loaded_file = Nokogiri::XML(open(@url))
    
  end
  
end

#.event
#  .event-thumbnail a img
#    {show_thumb}
#  .event-short-descrip a img
#    .event-date
#      {date}
#    h3.event-headline
#      {headline}
#    .supporting-act
#      {supporting-act}
#    .buy-tickets-button