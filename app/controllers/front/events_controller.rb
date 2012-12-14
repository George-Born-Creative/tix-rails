class Front::EventsController < ApplicationController
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def chart
    @event = @current_account.events.find(params[:id])
    @chart = @event.chart
  end
  
end
