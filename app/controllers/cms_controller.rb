class CmsController < ApplicationController
  respond_to :html
  
  def index
      @page = @current_account.pages.find_by_slug(params[:slug]) || @current_account.pages.find_by_slug('home')
      render :layout => 'sidebar_left'
  end
  
  
  def cms
    
  end
  
  
  
end