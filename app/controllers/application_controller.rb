class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout
  
  before_filter :set_event
  before_filter :authenticate_user!
  
  def set_event
    @events = Event.order("starts_at ASC")
  end
  
  
  private

  def layout
    if devise_controller? || resource_name == :user || action_name == 'sign_in' || action_name == 'sign_up'
     "login"
    else
     "application"
    end  
  end



end
