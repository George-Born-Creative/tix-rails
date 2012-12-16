class Front::EventsController < ApplicationController
  
  caches_action :show, :expires_in => 15.minutes, :cache_path => proc {
    "/events/#{params[:slug]}"
  }
  
  caches_action :chart, :expires_in => 1.minute, :cache_path => proc {
    "/events/#{params[:slug]}/seats"
  }
  
  
  
  def index
    render :text => params[:id]
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def chart
    @event = @current_account.events.find(params[:id])
    @chart = @event.chart
  end
  
end
