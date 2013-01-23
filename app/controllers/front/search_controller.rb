class Front::SearchController < ApplicationController  
  def index
    @sidebar = @current_account.sidebars.find_by_slug('current-sidebar')

    @query = params[:q]
    
    unless @query.blank?
      query_arr = @query.split(' ')
      
      @events = @current_account
        .events
        .current
        .announced
        .with_all_search_keywords(query_arr)
        .order_by_search_keywords_rank(query_arr)
    end
    
    respond_to do |format|
      format.html {render :layout => 'sidebar_right'}
    end
    
  end
end