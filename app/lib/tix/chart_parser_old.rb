require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'ostruct'

# Accepts an SVG (xml) file
# Parses it
# 
# 


class ChartParser
  
  def initialize(file)
    @loaded_file = Nokogiri::XML(open(file))
  end
  
  def parse
    groups = group_nodes # Nokogiri::XML::Nodeset
    @sections = {}
    
    groups.each do |group|
      
      areas = self.setup_areas_for_group(group) 
      active_areas = self.active_areas( areas)
      unique_fills = self.unique_fills( active_areas )
      
      unique_fills.each do |fill, i|
        exclude = [nil, '', 'none']
        unless exclude.include? fill
          @sections[fill] = self.areas_with_fill(areas, fill).map {|o| o.marshal_dump }
        end
      end
    end
    
    @sections
  end
  
  def areas_with_fill(areas, fill)
    areas = areas.select do |area|
      area.fill == fill
    end
   
    areas
  end
  
  def group_nodes
    @loaded_file.css('svg > g')
  end
  
  
  def create_sections(unique_fills)    
    return unique_fills.map do |fill, idx|
       self.create_section( "Section #{idx}")
    end
  end
  
  def create_section(label)
    {:label => label}
  end
  
  def active_areas(areas)
    areas = areas.select do |area|
      area.group_label.downcase == 'hot'
    end
    areas
  end
  
  def unique_fills(areas)
    areas = areas.map { |area| area.fill }
    areas.uniq
  end

  # array
  def setup_areas_for_group(group)
    group_label = group.attr 'id'
    
    
    areas = group.css('rect, polygon, circle, text')
                 .each_with_index
                 .map { |elem, idx|  setup_area(elem, group_label, idx) }
    
    areas
  end
  
  def setup_area(elem, group_label, idx)
    area = OpenStruct.new
    
    case elem.name
    
    when 'circle'
      area.cx = elem.attr 'cx'
      area.cy = elem.attr 'cy'
      area.r = elem.attr 'r'
    when 'text'
      area.type
      area.transform = elem.attr 'transform'
    when 'rect'
      area.x = elem.attr 'x'
      area.y = elem.attr 'y'
      area.width = elem.attr 'width'
      area.height = elem.attr 'height'
    when 'polygon'
      area.points = elem.attr 'points'
          
   end
   

    area.type = elem.name
    area.fill = elem.attr 'fill'
    area.index = idx
    area.group_label = group_label # used for sectioning

  
    area

  
  end
  
end
  
