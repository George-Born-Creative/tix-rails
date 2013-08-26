require 'spec_helper'

require './app/lib/tix/chart_parser'
require 'ostruct'
ENV['RACK_ENV'] = 'test'

describe ChartParser do
  before :all do
    @chart_parser = Tix::ChartParser.new('./spec/fixtures/chart.svg', 'jamminjava')
  end
    
  it "should initialize and provide correct account" do
    @chart_parser.account.subdomain.should eq 'jamminjava'
  end
    
  it "should create 4 sections" do
    @chart_parser.parse()
  end
  
end