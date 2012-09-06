class TicketLock
  attr_accessor :user_id, :ticket_id, :event_id, :key
  
  EXPIRE_TIME = 5 * 60 # 5 minutes
  
  
  def initialize(*args)
    args = args[0]
    @user_id = args[:user_id]
    @ticket_id = args[:ticket_id]
    @event_id = Ticket.find(@ticket_id).event.id
    
    @r = REDIS
  end  
  
  def save
    if is_available? 
      save!
      return true
    else
      return false
    end
  end
  
  def destroy!
    if is_locked?
      destory_lock!
      return true
    else
      return false
    end
  end
  
  
  def is_locked?
    result = @r.get(self.key)
        
    if result == nil
      return false 
    else
      return true
    end
  end
  
  def is_available?
    !is_locked?
  end
  
  def key
    "ticket:#{@ticket_id}:event:#{@event_id}:locked_by"
  end
  
  
  protected
  
  def destory_lock!
    p = Pusher['tickets'].trigger('unlock', { :ticket_id => self.ticket_id, :event_id => self.event_id }) #TODO: Move this into a queue with a worker consuming it
    @r.del(self.key)
  end
  
  def save!
    value = @user_id
    p = Pusher['tickets'].trigger('lock', { :ticket_id => self.ticket_id, :event_id => self.event_id }) #TODO: Move this into a queue with a worker consuming it
    
    @r.set(self.key, value)
    @r.expire(self.key, EXPIRE_TIME)
    # puts "Saved #{key}=#{value} expiring in #{EXPIRE_TIME}" 
  end
  
  
  # A Redis-backed model if one ticket is locked. Referenced by Tickets model in the form of Ticket.locked?

  # "ticket:134:locked" true 
  
end
