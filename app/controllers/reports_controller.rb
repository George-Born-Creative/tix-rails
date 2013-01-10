class ReportsController < ApplicationController
  respond_to :json, :html
  layout 'manager_reports'

  before_filter :populate_event_totals, :only => [:index, :event_sales]
  
  def index
    @event_totals = EventSalesAggregatesQuery.new(@current_account.id).exec
  end
  
  def event_guestlist
    @event = @current_account.events.find(params[:event_id])
    @orders = @current_account.orders.complete.joins(:tickets).where('tickets.event_id = ?', params[:event_id])
    @tickets = @current_account.tickets.complete.where('tickets.event_id = ?', params[:event_id])
  end
  
  def event_sales
    if params[:event_id].nil?
      @current_event = @current_account.events.select('id').where('starts_at < ?', Time.zone.now).order('starts_at DESC').first
      params[:event_id] = @current_event.id
    end
    @event = @current_account.events.find(params[:event_id])
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
  end
  
  private
  
  def populate_event_totals
    
  end
  
end