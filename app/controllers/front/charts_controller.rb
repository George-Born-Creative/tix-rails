class Front::ChartsController < ApplicationController

  
  def show
    @chart = @current_account.charts.find(params[:id])
    @event = @chart.event
  end
  
end
