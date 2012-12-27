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
