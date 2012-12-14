class Front::ChartsController < ApplicationController

  
  def show
    @event = @current_account.events.find(params[:id])
    @chart = @event.chart
  end
  
end
