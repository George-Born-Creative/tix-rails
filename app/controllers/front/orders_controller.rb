class Front::OrdersController < ApplicationController
  
  def new
    @order = Order.find(2)
  end
  
  def show
    @order = Order.find(2)
    
    # @chart = @current_account.charts.find(params[:id])
    # @event = @chart.event
  end
  
end
