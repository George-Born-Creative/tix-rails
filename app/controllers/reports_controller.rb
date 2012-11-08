class ReportsController < ApplicationController
  respond_to :json, :html

  def index
    @events = @current_account.events
          .select('title, id, starts_at, announce_at, on_sale_at, off_sale_at, remove_at, slug').order('starts_at ASC')
  end
  
  def event_guestlist
    @event = @current_account.events.find(params[:event_id])
    @tickets = @event.tickets.complete
    @orders = @tickets.map{ |ticket| ticket.order } 
  end
  
  def event_sales  # by day, by week, by month (start, stop)
    # params[:event_id]
  end
  
  def sales_over_time
    
  end
  
  
  
  
end