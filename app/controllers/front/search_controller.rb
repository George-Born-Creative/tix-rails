class Front::SearchController < ApplicationController  
  def index
    @sidebar = @current_account.sidebars.find_by_slug('current-sidebar')

    @query = params[:q]
    
    unless @query.blank?
      @events = @current_account.events.current.announced.where('title @@ to_tsquery(?)', "%#{@query}%")
    end
    
    respond_to do |format|
      format.html {render :layout => 'sidebar_right'}
    end
    
  end
end