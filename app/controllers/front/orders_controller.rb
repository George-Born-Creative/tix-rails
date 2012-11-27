class Front::OrdersController < InheritedResources::Base
  layout nil, :only => [:tickets]
  layout 'front_user', :except => [:tickets]
  
  before_filter :set_current_order
  before_filter :authenticate_user!, :except => [:add_to_cart, :remove_from_cart]

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
  end

  def remove_from_cart # POST /orders/remove_from_cart/:area_id 
    area_id = params[:area_id]
    @current_order.tickets.find_by_area_id(area_id).delete
    
    respond_to do |format|
      format.html{ redirect_to '/checkout' }
      format.js { render :json => {:message => 'success', :order => @current_order} }
    end
  end
  
  
  def tickets
    @order = @current_account.orders.find(params[:id])
    
    respond_to do |format|
      format.html { render :layout => false }
    end
    
  end

  private
 
  def collection
     @orders ||= end_of_association_chain.complete.order('purchased_at DESC') # ensure complete orders only
  
  end

  def begin_of_association_chain
    @current_user
  end
  
  
end
