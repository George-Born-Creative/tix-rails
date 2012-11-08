class Front::TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_employee
  
  layout 'checkin'

  def checkin
    @ticket = @current_account.tickets.find(params[:id])   
    @success = @ticket.checkin!     
  end
 
 
end

