require 'spec_helper'

describe "Order system" do
    
  before :each do
    puts '##################'
    
    Account.destroy_all
    
    @account = create(:account)
    @account.artists.create( attributes_for(:artist) ) 
    
    @account.gateways.create( attributes_for(:gateway) ).activate!
    
    @event = @account.events.create( attributes_for(:event) )
    @event.update_attribute(:headliner, @account.artists.first)
    
    @chart = create(:chart)
    @event.update_attribute(:chart, @chart)
    
    @section = @chart.sections.create( attributes_for(:section) )
    @area = @section.areas.create( attributes_for(:area) )
    @area_ga = @section.areas.create( attributes_for(:ga_area) )
    @order = @account.orders.create!
    
    @user = @account.users.create!( attributes_for(:user) )
  end
  
  it 'should have an artist and event' do
    @account.artists.count.should be 1
    @account.events.count.should be 1
    @event.headliner.id.should be @account.artists.first.id

  end

  it 'should have 1 max_tickets for single area' do
    @area.max_tickets.should be 1
    @area.inventory.should be > 0
  end

  it 'should add one ticket to cart' do
    @order.create_ticket(@area.id).should eq true
    @area.inventory.should be 0
  end

  it 'should fail to add a second ticket if inventory is null' do
    @order.create_ticket(@area.id).should eq true
    @area.inventory.should be 0
    @order.create_ticket(@area.id).should eq false
  end

  it 'should be in cart mode to start' do
    @order.cart?.should be true
  end

  it 'should have GA with more than 1 inventory and max_tickets' do
    max = @area_ga.max_tickets
    max.should be > 1
    @area_ga.inventory.should eq max
    @order.create_ticket(@area_ga.id).should eq true
    @order.tickets.count.should eq 1
    @area_ga.inventory.should eq max - 1
    @order.total_total.should eq @area_ga.section.current_price.total
  end

  it 'should add multiple tickets to cart and have correct totals' do
    n = 3
    n.times do 
      @order.create_ticket(@area_ga.id).should eq true
    end
    @order.total_total.should eq (@area_ga.section.current_price.total * n)
  end

  it 'should have a valid gateway' do
    @account.gateway.should_not be nil
    @account.gateway.authorize_net.class.should_not be nil
    @account.gateway.authorize_net.class.should be ActiveMerchant::Billing::AuthorizeNetGateway
  end


  it 'should perform web checkout' do
    puts 'should perform web checkout'

    (n=1).times do
      @order.create_ticket(@area_ga.id).should eq true
    end

    # @order.total.should eq (@area_ga.section.current_price.total * n)

    @order.card_purchase = true
    @order.deliver_tickets = true
    @order.deliver_tickets?.should be true
    @order.should_not be_valid

    @order.create_address!(  :address_line_1 => '123 Main St',
                             :address_line_2 => 'Apt 123',
                             :city => 'Silver Spring',
                             :state => 'MD',
                             :zip => '20904')

    @order.create_phone!(  :number => '301-956-0110')

    @order.update_attributes(:first_name => 'Shaun',
                             :last_name => 'Robinson',
                             :email => 'shaun@squiid.com',
                             :user => @user )

    @order.card_number = '370000000000002'
    @order.card_verification = '123'
    @order.card_expiration_month = 9
    @order.card_expiration_year = '2015'

    @order.should be_valid

    @order.purchase!.should be true

    @order.state.should eq 'complete'

    @order.transactions.last.success.should eq true

  end 


  it 'should perform agent checkout with delivery' do
    puts 'should perform agent checkout with delivery'

    (n=1).times do
      @order.create_ticket(@area_ga.id).should eq true
    end

    @order.deliver_tickets = true

    # @order.should_not be_valid # this validation was moved to the processing state

    @order.update_attributes(:first_name => 'Shaun',
                             :last_name => 'Robinson',
                             :email => 'shaun@squiid.com',
                             :agent => @user)

   @order.should be_valid
   @order.payment_method_name = 'cash'
   @order.purchase!.should be true
   @order.tickets.first.checked_in_at.should be nil
   @order.transactions.last.meth.should eq 'cash'
   @order.transactions.last.success.should eq true

  end

  it 'should perform agent checkout without delivery' do
    puts 'should perform agent checkout without delivery'

    (n=1).times do
      @order.create_ticket(@area_ga.id).should eq true
    end


    @order.update_attributes(:agent => @user)

    @order.payment_method_name = 'square'

    @order.should be_valid
    @order.purchase!.should be true
    @order.transactions.last.meth.should eq 'square'
    @order.transactions.last.success.should eq true
    @order.tickets.each {|t| t.checked_in_at.should be nil}

  end

  it 'should perform agent checkout with auto checkin' do
     puts 'should perform agent checkout auto checkin'

      (n=1).times do
        @order.create_ticket(@area_ga.id).should eq true
      end


      @order.update_attributes(:agent => @user)
      @order.checkin_tickets = true
      @order.payment_method_name = 'square'

      @order.should be_valid
      @order.purchase!.should be true
      @order.transactions.last.meth.should eq 'square'
      @order.transactions.last.success.should eq true

      @order.tickets.each do |t|
        t.checked_in_at.should_not be nil
        t.checked_in?.should be true
      end

  end

  it 'should perform agent checkout with service charge modificiation' do
     puts 'should perform agent checkout with service charge modificiation'

      # (n=rand(10)+1).times do
      (n=1).times do
        @order.create_ticket(@area_ga.id).should eq true
      end
      
      @order.update_attributes(:agent => @user)
      @order.checkin_tickets = true
      @order.payment_method_name = 'square'
      # @order.total_total.should eq ( @area_ga.section.current_price.total * n )
      
      @order.service_charge_override = 0.5
      
      @order.should be_valid
      @order.purchase!.should be true
        
      @order.total_service_charge.to_s.should eq ( 0.5 * n ).to_s
      @order.total_base_price.should eq ( @area_ga.section.current_price.base * n )
      
      @order.service_charge.to_s.should eq ( 0.5 * n ).to_s
      @order.base.should eq ( @area_ga.section.current_price.base * n )
      
  end
  
 
  
  
  # self.account = self.order.account
  # self.event_name = event.title_with_artists
  # self.event_name_1 = event.title_array[0]
  # self.event_name_2 = event.title_array[1]
  # self.event_id = event.id
  # self.event_artists = event.artists_str
  # self.event_starts_at = area.section.chart.event.starts_at
  # self.section_label = area.section.label
  # self.area_label = area.label
  # self.base_price = area.section.current_price.base
  # self.service_charge = area.section.current_price.service
  
  
end