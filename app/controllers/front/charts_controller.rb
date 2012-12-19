class Front::ChartsController < ApplicationController
  
  def show
    @event = @current_account.events.find(params[:id])
    @chart = @event.chart
    if @current_order.tickets.count == 0
      @current_order.reset_expires_at!
    end
  end
  
end
