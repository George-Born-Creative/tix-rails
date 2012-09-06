require './lib/svg_parser'
require 'spec_helper'
require 'ostruct'

describe SVGParser do

  before :all do
    
    @svg = SVGParser.new('./spec/resources/chart.svg')
  end
  
  before :each do 
    Section.delete_all
    
  end
  
  it "should return active areas given a structure" do
    area1 = OpenStruct.new
    area1.group_label = 'hot'
    area2 = OpenStruct.new
    area2.group_label = ''
    
    @svg.active_areas([area1, area2]).should eq [area1]    
  end
  
  it "should return only areas with unique fills" do
    area1 = OpenStruct.new
    area1.fill = '#333999'
    area2 = OpenStruct.new
    area2.fill = '#333999'
    area3 = OpenStruct.new
    area3.fill = '#295555'
    
    @svg.unique_fills([area1,area2,area3]).should eq [area1.fill,area3.fill]
  end
  
  it "should create AR sections given an array of unique fills" do
    unique_colors = ['#3399ff', '#aabbcc', '#666666']
    sections = @svg.create_sections(unique_colors)
    sections.class.should eq Array
    sections[0].class.should eq Hash
    sections.length.should eq unique_colors.length    
    
  end
  
  it "should have 2 group nodes" do
    @svg.group_nodes.count.should eq 2
  end
  
  it "should setup areas forgroup" do
    areas = @svg.setup_areas_for_group(@svg.group_nodes)
    areas.class.should be Array
    areas[0].class.should be OpenStruct
    
  end
  
  it "should parse into" do
    sections = @svg.parse
    sections.length.should eq 4
        
    sections.length.should be > 0
    
    sections.each do |k,v|
      puts "#{k} has #{v.count} items"
      v.count.should be > 0
      v.each do |i|
        i.class.should be Hash
      end
    end
  end
  
  
  
  
end