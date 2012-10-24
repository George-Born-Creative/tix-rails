class OrdersController < InheritedResources::Base
  respond_to :json, :html

  
  
  def tickets
    @tickets = Order.find(params[:id]).tickets
    
    respond_to do |format|
      format.html { }
      format.json { }
    end
  end
  
  
  
  protected
  
  def collection
    @orders ||= end_of_association_chain.order('created_at DESC')
  end
  
  def begin_of_association_chain
    @current_account
  end
  
  
end
