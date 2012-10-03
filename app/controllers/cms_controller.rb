class CmsController < ApplicationController
  respond_to :html
  layout 'sidebar_left'
  
  def index
    
    layout = params[:layout] == 'r' ? 'sidebar_right' : 'sidebar_left'
    
    case params[:slug]
      
    when nil
      @page = @current_account.pages.find_by_slug('home')
      render :layout => layout
      
    when "calendar"
      @events = @current_account.events.announced
            .select('title, starts_at, id, headliner_id, announce_at')
            .order('starts_at asc')
      render :template => 'shared/calendar', :layout => layout
      
    else
      @page = @current_account.pages.find_by_slug(params[:slug])#  || not_found
      render :layout => layout
    end
    
    
  end
  
  
  
  
end