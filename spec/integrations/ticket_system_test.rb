require 'spec_helper'

describe 'Ticket System Integration' do
  
  before :each do 
    Account.delete_all
    Ticket.delete_all
    @account = Account.create!(:subdomain => 'hi')
    @event = @account.events.create(:starts_at => DateTime.now)
    
    @chart = @account.charts.create(:master => false, :event => @event)
    @section = @chart.sections.create#!(:label => 'S', :seatable => true)
    @area = @section.areas.create!(:label => 'Seated', :type => 'circle')
    @order = Order.create
  end
  
  
  it 'should create order with default status cart' do
    @order = @account.orders.create!
    @order.state.should eq 'cart'
  end

  
  it 'should add tickets to order and ticket should have lock' do
    @area.inventory.should eq 1
    @ticket = @order.tickets.create(:area => @area)
    @ticket.state.should eq 'reserved'
    @area.inventory.should eq 0
  end
  
  
  it 'should add tickets to order and ticket should have lock' do
    @area.max_tickets = 55
    @area.inventory.should eq 55
    5.times do
      @ticket = @order.tickets.create(:area => @area)
    end
    @ticket.update_attributes(:state => 'purchased') #last ticket
    @area.inventory.should eq 50

  end
  
  it "should reserve tickets when added to order" do
    @order.reserve(@area.id).should be true
  end
  
  it "should fail to add tickets beyond inventory" do
    @area.max_tickets.should eq 1
    @area.inventory.should eq 1
    @order.reserve(@area.id).should be true
    @order.reserve(@area.id).should be false
    @area.inventory.should eq 0    
  end
  
  it "should correctly set order expiration" do
    (@order.expires_at - DateTime.now).should be < Order::LIFESPAN
  end
  
  
end