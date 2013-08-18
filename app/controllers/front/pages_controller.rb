class Front::PagesController < ApplicationController
  before_filter :set_current_page, only: :show
  before_filter :bust_cache, only: :show
  
  def show
    respond_to do |format|
      unless @page.nil?
        # format.html { render text: @page.cache_key }
        format.html do
          template = @page.slug == 'home' ? 'show_home' : 'show' 
          render template
        end
      else
        format.html { not_found  } # 404
      end
    end
  end
  
  protected
  
  def bust_cache
    if params[:bust_cache] == 'yes' and not @page.nil?
      cache_key = 'views/' + @page.cache_key
      Rails.cache.delete cache_key
      Rails.logger.debug "Busting cache #{cache_key}" 
    end
  end
  
  def set_current_page
    slug = params[:slug] || 'home'
    @page = @current_account.pages.find_by_slug(slug)
  end
end
