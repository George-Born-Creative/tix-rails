class OrdersController < InheritedResources::Base
  respond_to :json, :html

  def tickets
    @tickets = Order.find(params[:id]).tickets
    
    respond_to do |format|
      format.html { }
      format.json { }
    end
  end
  
  def resend_tickets
    @email = params[:email]
    @order = Order.find(params[:id])
    
    if @email.nil?
      @response = "Email cannot be blank."
    elsif @order.nil?
      @response = "Order ##{params[:id]} not found."
    else
      @order.deliver_tickets!(@email)
      @response = "Tickets were emailed to #{@email}"
    end
    
    respond_to do |format|
      format.js {  }
    end
    
  end
  
  protected
  
  def collection
    @orders ||= end_of_association_chain
      .complete
      .order('created_at DESC')
      .page(params[:page] || 1)
      .per(params[:per] || 10)
  end
  
  def begin_of_association_chain
    @current_account
  end
  
  
end
