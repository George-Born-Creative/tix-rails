require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'ostruct'

# Accepts an SVG (xml) file
# Expects a certain schema (Seating Chart generated from Adobe Illustrator)
# Creates an (AR) Section with Stack ID
# Creates (AR) Areas within those sections

module Tix
  
  class ChartParser
    SEATABLE_SECTION_ID = 'Sections'
  
    def initialize(file, account_subdomain)
      @file = file
      
      @loaded_file = Nokogiri::XML(open(file))
      
      @account = Account.find_or_create_by_subdomain(account_subdomain)
    end
    
    
    def filename
      File.basename(@file, '.svg')
    end
  
    # Creates Hash of Area. Can be used with .create(area)
    def parse_area(elem)
      
       area = OpenStruct.new
       area.type = elem.name
       area.color = elem.attr 'fill'
       
       case elem.name 
       
         when 'circle'
           area.cx = elem.attr 'cx'
           area.cy = elem.attr 'cy'
           area.r = elem.attr 'r'
         when 'text'
           area.transform = elem.attr 'transform'
           coords = /1 0 0 1 ([\d\.]+) ([\d\.]+)/.match(area.transform)
           area.x = coords[1]
           area.y = coords[2]
           area.text = elem.inner_text
           #puts "TEXT: #{elem.inner_text} X: #{area.x} Y: #{area.y}"
         when 'rect'
           area.x = elem.attr 'x'
           area.y = elem.attr 'y'
           area.width = elem.attr 'width'
           area.height = elem.attr 'height'
         when 'polygon', 'polyline'
           area.points = elem.attr 'points'
           

      end
      
      area.marshal_dump
    end
    
    # Creates (AR) Section within (AR) Account    
    def parse_section(css, stack_index, seatable=false)
      
      section_name = css.split('#')[-1]
      puts "   Section: #{section_name}  Active: #{seatable.to_s} "
      ActiveRecord::Base.silence do
        section = @chart.sections.create( :label => section_name,
                                          :seatable => seatable,
                                          :index => stack_index )
                                          
        # section.prices.create(:label => 'presale', :base => 10.00, :service => 3.00 )
        # section.prices.create(:label => 'day_of', :base => 12.00, :service => 12.00  )

        @loaded_file.css("#{css} circle, #{css} text, #{css} rect, #{css} polygon").each do |elem|
          area_hash = parse_area(elem)
          puts "     #{area_hash[:type]} (Area)"
          section.update_attributes(:color => area_hash[:color]) if section.color.blank?
          area_hash.delete :color
          section.areas.create( area_hash )
        end
        
        
        
        
        
        
        puts "Section color is #{section.color}"
        
        
        
      end
      
      
    end
    
    
    def parse
      unless self.valid?
        @validation_errors << "Invalid format. Please check Thintix Chart Spec"
        print_errors
        return false
      end
      
      # Otherwise, get on with it...
      
      # Create Chart
      @chart = @account.charts.create(
                                    :label => filename,
                                    :width => @loaded_file.css('svg').attr('width'),
                                    :height => @loaded_file.css('svg').attr('height'),
                                    :master => true
                                    )
  
                                    
      puts "Creating Chart #{@chart.name}"
      
      # Sections
      idx = 0
      # Background
      parse_section('svg > g#Background', idx)
      parse_section('svg > g#Background-Above', idx+=1)
      
      # Sections (seatables)
      @loaded_file.css('svg > g#Sections > g').each do |section|
        section_id = section.attr('id')
        parse_section("svg > g#Sections > g##{section_id}", idx+=1 , true)
      end
      
      # Foreground
      parse_section('svg > g#Foreground', idx+=1)
    end
    
    
    def check_for_css(css)
      unless @loaded_file.css(css).size > 0
        @validation_errors << "Input needs an #{css}" 
      end
    end
    
    def check_excludes_css(css)
      unless @loaded_file.css(css).size == 0
        @validation_errors << "Input should not have an #{css}" 
      end
    end
    
    
    def print_errors
      pretty_print_array_of_strings(@validation_errors) unless error_free?
    end
    
    
    def error_free?
      @validation_errors.size == 0
    end


    def pretty_print_array_of_strings(array_of_strings)
      unless error_free?
        array_of_strings.each { |msg| puts msg }
      else
        puts "No messages"
      end
    end
    

    def valid?
      @validation_errors = []
      # Has Background, Sections, Foreground groups as children of root
      check_for_css('svg > g#Background')
      check_for_css('svg > g#Sections')
      check_for_css('svg > g#Foreground')
      

      # Sections has multiple Section svg > g#Sections > g
      check_for_css('svg > g#Sections > g')
      
      print_errors
      
      return error_free?
    end
  
  end
  
  
  
  
  
end