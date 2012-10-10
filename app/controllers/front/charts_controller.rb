class Front::ChartsController < ApplicationController
  before_filter :set_current_order 
  
  
  def show
    @chart = @current_account.charts.find(params[:id])
    @event = @chart.event
  end
  
end
