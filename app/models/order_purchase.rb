class OrderPurchase
  # :method, :origin, :deliver_tickets
  
  # :first_name, :last_name, :address_line_1, :address_line_2
  # :city, :state, :zip, 
  
  # :user, :agent
  
  # :card_number, :card_verification, :card_expiration_month, :card_expiration_year
  
  # Take a proactive approach with the order, buidling a final object by collecting
  # all info provided along the way.  Even if the order is not successful, this info
  # will be available for debugging and analysis.
  
  attr_reader   :order
    
  delegate      :first_name, :last_name,
                :address_line_1, :address_line_2,
                :ip_address,
                :city, :state, :zip,
                :phone,
                :card_number, :card_verification, 
                :card_expiration_month, :card_expiration_year,
                
                :total, 
                :price_in_cents, 
                :email_tickets, 
                :transactions, 
                :account, 
                :user, 
                
                # AR METHODS 
                :save, 
                :update_attribute,
                :update_attributes,
                :errors,  :to => :order
                
            
  attr_accessor :auto_check_in, :deliver_tickets, 
                :update_user_phone_and_address, :card_purchase
                
    
  
  def initialize(order)
    @order = order
  end
  
  def purchase!(opts = {})
    opts.reverse_merge! :card_purchase => false, :check_in_tickets => false
    
    @card_purchase = opts[:card_purchase]
    @check_in_tickets = opts[:check_in_tickets]
    
    # update_order
    
    success = card_purchase? ?  purchase_with_card! : purchase_without_card!
    
    if success
      order.finalize! 
      order.check_in_tickets! if @check_in_tickets
    end
    
  end
  
  def update_order
    
    if card_purchase?

      address.create!(  :address_line_1 => address_line_1, 
                        :address_line_2 => address_line_2,
                        :city => city,
                        :state => state,
                        :zip => zip ) 
            
    
      
      order.update_attributes(    :user => @user, 
                                  :card_expiration_month => card_expiration_month,
                                  :card_expiration_year => card_expiration_year,
                                  :first_name => :first_name,
                                  :last_name => :last_name,
                                  :address => _address,
                                  :phone => _phone
                             )
    end
  end
  
  
  def create_transaction!(opts={})
    
    options = opts.reverse_merge(  :action => "purchase", 
                                   :amount => price_in_cents,
                                   :meth => @method,
                                   :origin => @origin,
                                   :success => true )
    
    transactions.create!( options )
    
  end
  
  def card_purchase?
    @card_purchase
  end
  
  
   
   
  
end