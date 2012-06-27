require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'ostruct'

class SVGParser
  attr_accessor :single_seats
  
  def initialize(svg_path = nil)
    @svg_path = svg_path
    @single_seats = []
    @area_seats = []
    
    load_file
    parse_file  
  end
  
  # Return Nokogiri Object
  def load_file()
    @loaded_file = Nokogiri::XML(open(@svg_path))
  end
  
  def parse_file()
    parse_single_seats
    # parse_area_seats
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
    @loaded_file.css('polygon') do
      seat = OpenStruct.new
      points = node['points']
    end
  end
  
  
  def polygon_to_path(poly)
    poly.gsub! /\n/, ''
    # poly.gsub! /([0-9.-]+),([0-9.-]+)/ do |match|
    #    "L #{$1},#{$2}"
    # end
    # poly.gsub! /^L/, 'M'
    #poly += ' z'
    poly = "M ${poly} z"
    poly
  end
  
  
  def to_s
    return @single_seats.to_s
  end
  
  def to_json(pretty_print=false)
    as_hash = self.to_hash    
    as_hash.to_json
  end
  
  def to_yaml
    as_hash = self.to_hash    
    as_hash.to_yaml
  end
  
  # def json_to_file(local_filename, args={})
  #   pretty = args[:pretty] || false
  #   doc = self.to_hash
  #   if pretty
  #     doc = JSON.pretty_generate(doc) 
  #   else
  #     doc = doc.to_json
  #   end
  #   write_file(local_filename, doc)
  # end
  # 
  # def yaml_to_file(local_filename, args={})
  #   doc = self.to_hash.to_yaml
  #   write_file(local_filename, doc)
  # end
  # 
  # def write_file(local_filename, doc)
  #   File.open(local_filename, 'w') {|f| f.write(doc) }   
  # end
  
  def to_hash
    all_seats = []
    @single_seats.each do |seat|
      all_seats.push seat.as_hash
    end
    all_seats
  end
  
end