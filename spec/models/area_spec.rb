# == Schema Information
#
# Table name: areas
#
#  id            :integer          not null, primary key
#  label         :string(255)
#  label_section :string(255)
#  polypath      :string(255)
#  x             :decimal(, )
#  y             :decimal(, )
#  stack_order   :integer          default(0)
#  chart_id      :integer
#  type          :string(255)
#  section_id    :integer
#  cx            :decimal(, )
#  cy            :decimal(, )
#  r             :decimal(, )
#  width         :decimal(, )
#  height        :decimal(, )
#  transform     :string(255)
#  points        :string(255)
#  max_tickets   :integer          default(1), not null
#  text          :string(255)
#

require 'spec_helper'

describe Area do

  before :all do
    Area.delete_all
  end
  
  it "should create a circle" do
    Area.create(type: 'circle', label: 'A5', x: 15.0, y: 15.0).should be_valid    
  end
  
  it "should create a polygon" do
    Area.create(type: 'polygon', label: 'General Admission', polypath: 'A123B').should be_valid
  end
  
  it "should create a square" do 
  end
  
  
end
