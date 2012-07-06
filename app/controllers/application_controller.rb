class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_event
  
  def set_event
    @events = Event.all
  end
end
