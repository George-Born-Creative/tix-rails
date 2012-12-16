class Front::EventsController < ApplicationController
  
  caches_action :show, :expires_in => 15.minutes, :cache_path => proc {
    "/events/#{params[:slug]}"
  }
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  
end
