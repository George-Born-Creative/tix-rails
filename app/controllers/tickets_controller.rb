class TicketsController < ApplicationController
  respond_to :json#, :html

  def create
    order = @current_account.orders.find( params[:ticket][:order_id] )
    area_id =  params[:ticket][:area_id]
    
    order.create_ticket(area_id)
    
    respond_with order
    #render :text => params[:ticket].to_json
  end

  
  # def check_in
  #   
  #   @ticket = Ticket.find(params[:id])
  #   
  #   @success = @ticket.check_in!
  #   
  #   respond_to do |format|
  #     if @success
  #       format.html { render :layout => 'checkin' }
  #       format.json { }
  #     else
  #       format.html { render :layout => 'checkin'}
  #       format.json { }
  #     end
  #   end
  # end
end
