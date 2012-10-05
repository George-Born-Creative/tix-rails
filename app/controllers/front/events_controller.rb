class Front::EventsController < ApplicationController
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
  end
  

  
end
