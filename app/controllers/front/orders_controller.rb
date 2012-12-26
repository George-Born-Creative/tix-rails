class Front::OrdersController < InheritedResources::Base
  layout nil, :only => [:tickets]
  layout 'application', :only => [:new]
  
  layout 'front_user', :except => [:tickets, :new]
  
  before_filter :set_current_order
  before_filter :ensure_order, :only => [:new, :create]
  before_filter :authenticate_user!, :except => [:add_to_cart, :remove_from_cart, :new, :create]

  def show
    @order = @current_user.orders.where(:id => params[:id]).first
    
    unless @order
      redirect_to '/', :notice => "You are not authorized to access this order."
    end
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    prefill_fields
  end
  
  def prefill_fields
    # Only pre fill fields for customer checkout
    
    unless @current_user.nil? || @current_user.has_at_least_role(:employee)
      if @current_order.address.nil?
        @current_order.build_address
        # @current_order.build_address(@current_user.address.attributes.except('id','created_at', 'updated_at'))
      end  

      if @current_order.phone.nil?
        @current_order.build_phone
        # @current_order.build_phone(@current_user.phone.attributes.except('id','created_at', 'updated_at'))
      end  

      @current_order.first_name ||= @current_user.first_name
      @current_order.last_name ||= @current_user.last_name
      @current_order.email ||= @current_user.email
    end
    
    @current_order.build_address if @current_order.address.nil?
    @current_order.build_phone if @current_order.phone.nil?
    
      
  end
  
  def create
     # @order = @current_order
     
     if params[:order][:agent_checkout]
       params[:order][:agent] = @current_user
     else
       params[:order][:user] = @current_user
       params[:order][:card_purchase] = true     
       params[:order][:deliver_tickets] = true
       params[:order][:payment_method_name] = 'card'
       params[:order][:payment_origin_name] = 'web'
       
     end
     
     
     parse_date! 
     
     prefill_fields
     
     @current_order.update_attributes(params[:order])
     # @current_order.address_attributes = params[:order][:address_attributes]
     # @current_order.phone_attributes = params[:order][:phone_attributes]
     
     #params[:order].keys.each do |key|
     #   @current_order.update_attribute(key, params[:order][key] )
     #end

      redirect_path = params[:order][:agent_checkout] ? '/orders/new' : '/orders/new?checkout=customer'
      
      respond_to do |format|
        format.html{ 
          if @current_order.valid?
            # puts '@current_order.valid? IS TRUE'
            if @current_order.purchase && @current_order.state == 'complete'
              # puts 'purchase! is true and state == complete'
              
              redirect_to '/orders/success', :notice => 'Order successful!'
            else
              flash[:message] = @current_order.errors.full_messages.join('<br/>').html_safe
              flash[:message] += @current_order.credit_card.errors.full_messages.join('<br/>').html_safe
              flash[:message] += @current_order.transactions.last.message unless @current_order.transactions.last.nil?
              # puts 'current order errors full messages'
              # @current_order.errors.full_messages
              # if @current_order.transactions.last
              #   puts 'current order errors full messages'
              #   @current_order.transactions.last.message
              # end
              # flash[:message] = @order.transactions.first.message
              # flash[:order] = @order
              redirect_to redirect_path
            end
          else # Checkout object did not pass validation
            puts  '@current_order.valid? IS FALSE'
            flash[:message] = @current_order.errors.full_messages.join('<br/>').html_safe
            puts 'messages'
            puts @current_order.errors.full_messages
            # flash[:order] = @order
            
            redirect_to redirect_path
          end
        }
      end
     
  end
  
  # http://accidentaltechnologist.com/ruby-on-rails/damn-you-rails-multiparameter-attributes/
  def parse_date!
    params[:order][:card_expiration_month] = params[:order][:"card_expiration_date(2i)"].to_i
    params[:order][:card_expiration_year] = params[:order][:"card_expiration_date(1i)"].to_i
    
    params[:order].delete(:"card_expiration_date(1i)")
    params[:order].delete(:"card_expiration_date(2i)")
    params[:order].delete(:"card_expiration_date(3i)")
  end
  

  def add_to_cart # POST /orders/add_to_cart/:area_id 
    area_id = params[:area_id]
    respond_to do |format|
      if @current_order.create_ticket(area_id)
        format.js { render :json => {:message => 'success', :order => @current_order} }
      else
        format.js { render :json => {:message => 'fail'}, :status => :unprocessable_entity }
      end
    end
  end
  
  def success
    if session[:success_order_id].nil?
      redirect_to '/orders/new', :message => 'Please complete your order first'
    else    
      @order = @current_account.orders.find( session[:success_order_id] )
    end    
  end

  def remove_from_cart # POST /orders/remove_from_cart/:area_id 
    area_id = params[:area_id]
    @current_order.tickets.find_by_area_id(area_id).delete
    
    respond_to do |format|
      format.html{ redirect_to '/orders/new' }
      format.js { render :json => {:message => 'success', :order => @current_order} }
    end
  end
  
  
  def tickets
    @order = @current_account.orders.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
    
  end

  def checkin_tickets!
    @order = @current_account.orders.find(params[:id])
    @order.checkin_tickets!
    
    redirect_to request.referer
  end
  
  private
 
  def collection
     @orders ||= end_of_association_chain.complete.order('purchased_at DESC') # ensure complete orders only
  end

  def begin_of_association_chain
    @current_user
  end
  
  def ensure_order
    if @current_order.tickets.count == 0
      redirect_to '/', :notice => 'You have no items in your Shopping Cart!'
    end
  end
  
  
end
