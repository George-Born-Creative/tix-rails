class TicketLocksController < ApplicationController
  respond_to :json

  # POST /ticketlocks/new.json with params :ticket_id, :user_id
  def new
    ticket_id = params[:ticket_id]
    user_id = params[:user_id]
    
    @ticket_lock = TicketLock.new(:ticket_id => ticket_id, :user_id => user_id)
    
    if @ticket_lock.save
      render :json => {:status => 'ok', :time => 300 }
    else
      render :json => {:status => 'error', :message => 'This ticket is already locked.'}
    end
  end
  
  def destroy
    ticket_id = params[:ticket_id]
    
    @ticket_lock = TicketLock.new(:ticket_id => ticket_id)
    
     if @ticket_lock.destroy!
        render :json => {:status => 'ok', :time => 300, :action =>  'deleted' }
      else
        render :json => {:status => 'error', :message => 'This ticket is not locked.'}
      end
  end

end

