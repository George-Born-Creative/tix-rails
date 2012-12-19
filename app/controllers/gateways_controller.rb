class GatewaysController < InheritedResources::Base

  
  def show
    redirect_to :action => :index
  end
  
  def activate
     @gateway = @current_account.gateways.find(params[:id])
     if @gateway.activate!
       redirect_to gateways_path, :notice => 'Gateway has been activated'
     else
       redirect_to gateways_path, :notice => 'Error: gateway not activated'
     end
   end
  
  protected 
  
  def begin_of_association_chain
    @current_account
  end
  
  
end