# == Schema Information
#
# Table name: tickets
#
#  id                      :integer          not null, primary key
#  price                   :decimal(, )
#  event_id                :integer
#  area_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  order_id                :integer
#  account_id              :integer          not null
#  base_price              :decimal(, )
#  service_charge          :decimal(, )
#  area_label              :string(255)
#  section_label           :string(255)
#  checked_in_at           :datetime
#  status                  :string(255)
#  event_name              :string(255)
#  event_starts_at         :datetime
#  event_artists           :string(255)
#  event_name_1            :string(255)
#  event_name_2            :string(255)
#  service_charge_override :decimal(, )
#

require 'spec_helper'


describe Ticket do
  
  
  before :each do
    @ticket = Ticket.create( 
                          :event_id => 0, 
                          :area_id => 0,
                          :area_label => 'A3', 
                          :section_label => 'General Admission',
                          :base_price => 10.00,
                          :service_charge => 3.00,
                          :status => 'open'
                        )
                        
  end
  
  
  it "initializes given an an event" do

                        
  @ticket.event_id.should eq 0
  @ticket.area_id.should eq 0
  @ticket.area_label.should eq 'A3'
  @ticket.section_label.should eq 'General Admission'
  @ticket.base_price.should eq 10.00
  @ticket.service_charge.should eq 3.00
  @ticket.total.should eq 13.00
  @ticket.status.should eq 'open'
  
  end
  
  it "returns a correct total given a service charge and price" do
    @ticket.total.should eq 13.00
  end
  
  
  it "should delete all" do
    Ticket.delete_all
    Ticket.count.should eq 0
  end
  
  it "should lock when someone adds it to the cart" do
    @ticket.lock(5) # user id = 5
    
  end
  
  it "should return all tickets by event id" do

  end
    
  
  it "should set count" do

  end
  
  
  
end
