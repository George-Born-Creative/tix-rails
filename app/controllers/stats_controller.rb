class StatsController < ApplicationController
  attr_accessor :overview
  respond_to :json
  
  def overview
    @counts = {
      :events => Event.count,
      :artists => Artist.count,
      :tickets => Ticket.count
    }
    respond_with @counts
  end
  
  
end