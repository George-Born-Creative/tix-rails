class CmsController < ApplicationController
  respond_to :html
  layout 'sidebar_left'
  
  def index
    if params[:slug].nil?
      @page = @current_account.pages.find_by_slug('home')
    else
      @page = @current_account.pages.find_by_slug(params[:slug])#  || not_found
    end
    
  end
  
  
end