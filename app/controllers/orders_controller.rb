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
    start_date = params[:from].blank? ? Time.at(0) : DateTime.strptime(params[:from], '%m/%d/%Y').to_date.beginning_of_day
    end_date = params[:to].blank? ? Time.now : DateTime.strptime(params[:to], '%m/%d/%Y').to_date.end_of_day
    date_sort_order = params[:date_sort] == 'asc' ? 'ASC' : 'DESC'
    
    @orders ||= end_of_association_chain
      .complete
      .purchased_between(start_date, end_date)
      .search(params[:q])
      .order("created_at #{date_sort_order}")
      .page(params[:page] || 1)
      .per(params[:per] || 50)
      
      @sql = @orders.to_sql
      

      
  end
  
  def begin_of_association_chain
    @current_account
  end
  
  
end
