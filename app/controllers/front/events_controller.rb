class Front::EventsController < ApplicationController
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
    
    unless @event.announced? || @current_user && @current_user.has_at_least_role(:employee)
      not_found
    end 
      
  end
  
  
end
