class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  # before_filter :authenticate_user!
  before_filter :set_current_account
  before_filter :set_events

     
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
    else
     "application"
    end  
  end



end
