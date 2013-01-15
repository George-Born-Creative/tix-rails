class Front::EventsController < ApplicationController
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
    
    # If event is not announced, only show to employees
    # or if preview params is yes
    unless @event.announced? || 
        (@current_user && @current_user.has_at_least_role(:employee)) || 
        params[:preview] == 'yes'
        
      not_found
    end 
      
  end
  
  
end
