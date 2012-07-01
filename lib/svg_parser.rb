require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'ostruct'

# Takes an SVG file and returns it as a hash. For use in seed.rb
# Must also add price, seat names, seat sections, etc after
# TODO: Seats in 2 colors, Polygons in 2 colors. 
# 1 color each becomes a seat. The other color of each becomes bg
class SVGParser
  attr_accessor :single_seats, :area_seats
  
  def initialize(svg_path = nil)
    @svg_path = svg_path
    @single_seats = []
    @area_seats = []
    
    load_file
    parse_file  
  end
  
  # Return Nokogiri Object
  def load_file
    @loaded_file = Nokogiri::XML(open(@svg_path))
  end
  
  def parse_file
    parse_single_seats
    parse_area_seats
  end
  
  def parse_single_seats
    @loaded_file.css('circle').each do |node|
      seat = OpenStruct.new
      seat.x = node['cx']
      seat.y = node['cy']
      # seat.fill = node['fill']
      # seat.r = node['r']
      # puts seat.marshal_dump
      @single_seats.push seat.marshal_dump
    end
  end
  
  def parse_area_seats
    @loaded_file.css('polygon').each do |node|
      seat = OpenStruct.new
      points = node['points']
      seat.poly = polygon_to_path(points)
      @area_seats.push(seat.marshal_dump)
    end
  end
  
  
  def polygon_to_path(poly)
    poly.gsub!(/\n/, '')
    poly.gsub!(/   /, ' ')
    poly = "M #{poly} z"
    poly
  end
  
  
  #def to_s
  #  return self.to_hash.to_s
  #end
  #
  def inspect
    return self.to_hash.to_s
  end
  
  def to_json(pretty_print=false)
    as_hash = self.to_hash    
    as_hash.to_json
  end
  
  def to_yaml
    as_hash = self.to_hash    
    as_hash.to_yaml
  end

  def to_hash
    {'area_seats' => @area_seats, 'single_seats' => @single_seats}
  end
  
end