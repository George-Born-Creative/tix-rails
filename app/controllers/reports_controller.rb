class ReportsController < ApplicationController
  respond_to :json, :html
  layout 'manager_reports'
  
  def index
  end
    
  def event_totals
    @events = EventSalesTotalsQuery.new(@current_account.id).exec
    render :layout => 'manager_reports_events'
  end
  
  def event_sales
    if params[:event_id].nil?
      @current_event = @current_account.events.select('id').where('starts_at < ?', Time.zone.now).order('starts_at DESC').first
      params[:event_id] = @current_event.id
    end
    @event = @current_account.events.find(params[:event_id])
    render :layout => 'manager_reports_events'
  end
  
  def sales_over_time
    params[:day] = Date.today.to_s if params[:day].nil?
    @day = Date.strptime( params[:day], "%Y-%m-%d" )
    @orders = @current_account.orders.purchased_on_date( params[:day] )
  end  
  
  def most_valuable_customers
    @customers = User.most_valuable_customers(:account_id => @current_account.id)
  end
  
  def checkin
    if params[:event_id].nil?
      @current_event = @current_account.events.select('id').where('starts_at < ?', Time.zone.now).order('starts_at DESC').first
      params[:event_id] = @current_event.id
    end
    @event = @current_account.events.find(params[:event_id])
    render :layout => 'manager_reports_events'
    
  end
  
  def guestlist
    @event = @current_account.events.find(params[:event_id])
    
    render :layout => 'manager_reports_events'
  end
  
  private
  
  
end