require 'spec_helper'

describe 'Ticket System Integration' do
  
  before :each do 
    Account.delete_all
    @account = Account.create!(:subdomain => 'hi')
    
    @chart = @account.charts.create
    @section = @chart.sections.create#!(:label => 'S', :seatable => true)
    
    @area = @section.areas.create(:label => 'Seated')
    @order = Order.create
  end
  
  
  it 'should create order with default status cart' do
    @order = @account.orders.create!
    @order.state.should eq 'cart'
  end
  
  it 'should add tickets to order and ticket should have lock' do
    @area.max_tickets.should eq 1
    @ticket = @order.tickets.create(:area => @area)
    @ticket.state.should eq 'locked'
    @area.max_tickets.should eq 0
  end
  
end