class ReportsController < ApplicationController
  respond_to :json, :html

  def index
    
    @events = @current_account.events
    
    if params[:time] == 'historical'
      @events = @events.historical
    elsif params[:time] == 'current'
      @events = @events.current
    else
      @events = @events.current
    end
      
    @events = @events
          .select('title, id, starts_at, announce_at, on_sale_at, off_sale_at, remove_at, slug').order('starts_at ASC')
  
  
  end
  
  def event_guestlist
    @event = @current_account.events.find(params[:event_id])
    @tickets = @event.tickets.complete
    @orders = @tickets.map{ |ticket| ticket.order } 
  end
  
  def event_sales  # by day, by week, by month (start, stop)
    # params[:event_id]
    @event = @current_account.events.find(params[:event_id])
    
  end
  
  def sales_over_time
    @orders = @current_account.orders.purchased_on_date(params[:day])
  end
  
  
  
  
end