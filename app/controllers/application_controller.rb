class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  # before_filter :authenticate_user!
  before_filter :set_current_account
  before_filter :authenticate_admin!
     
  private


  def set_current_account
    @current_account = Account.find_by_subdomain!(request.subdomains.first)
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
     # Pass if this isn't the manager page
      return true unless manager_page?

      # User must be sign in. 
      # If not, redirect to sign in page
      unless user_signed_in? 
        # redirect_to new_user_session first, :notice => 'Must sign in first'
        # return false
        authenticate_user!
      end

      # Must be employee or higher
      # If not, take home
      unless current_user.has_at_least_role(:employee)
        redirect_to root_path, :notice => 'Insufficient permissions'
        return false       
      end
  end
  
  unless Rails.application.config.consider_all_requests_local
     rescue_from Exception, with: lambda { |exception| render_error 500, exception }
     rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
   end

  
  protected
  
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => @current_account.id, :assetable_type => 'Account' }.merge(options))
  end

  
  private
  
  def manager_page?
    request.fullpath.slice(0,8) == '/manager'
  end
  
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
  



end
