class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  # before_filter :authenticate_user!
  before_filter :set_current_account
  before_filter :set_events
  before_filter :authenticate_admin!
     
  private


  def set_current_account
    @current_account = Account.find_by_subdomain!(request.subdomains.first)
  end

  def set_events # maybe move this into main controller
    @events = @current_account.events.order("starts_at ASC")
  end


  def layout
    if devise_controller? || action_name == 'sign_in' || action_name == 'sign_up'
     "login"
    elsif request.fullpath.slice(0,8) == '/manager'
      "manager"
    elsif request.fullpath.slice(0,6) == '/admin'
      "admin"
    else
     "application"
    end  
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.has_at_least_role(:employee)
      root_url << 'manager'
    else
      super
    end
  end
  
  
  def authenticate_admin!
    if request.fullpath.slice(0,8) == '/manager'
      if (! user_signed_in? )
        redirect_to new_user_session_path, :alert => 'Please sign in first '
      elsif !(current_user.has_at_least_role(:employee))
        redirect_to '/', :notice => 'Insufficient role '
      else
        true
      end
    end
  end
  
  protected
  
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => @current_account.id, :assetable_type => 'Account' }.merge(options))
  end

  
  
  #private

  #def render_404
  #  render :template => 'error_pages/404', :layout => "application", :status => :not_found
  #end


end
