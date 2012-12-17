class Front::ChartsController < ApplicationController
  
  def show
    @event = @current_account.events.find(params[:id])
    @chart = @event.chart
    @sections = Section.where(:chart_id => @chart.id).includes(:areas)

  end
  
end
