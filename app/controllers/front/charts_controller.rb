class Front::ChartsController < ApplicationController
  
  def show
    @event = @current_account.events.find(params[:id])
    
    not_found unless @event.announced? && @event.on_sale?
    
    @chart = @event.chart.decorate
    
    @inventories = Chart.inventories_optimized(@chart.id)
    if @current_order.tickets.count == 0
      @current_order.reset_expires_at!
    end
  end
  
end
