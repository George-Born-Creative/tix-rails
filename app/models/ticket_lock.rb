class TicketLock
  attr_accessor :user_id, :ticket_id
  
  EXPIRE_TIME = 5 * 60 # 5 minutes
  
  
  def initialize(*args)
    args = args[0]
    @user_id = args[:user_id]
    @ticket_id = args[:ticket_id]

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
  
  
  def is_locked?
    key = "ticket:#{@ticket_id}:locked_by"
    result = @r.get(key)
        
    if result == nil
      return false 
    else
      return true
    end
  end
  
  def is_available?
    !is_locked?
  end
  
  
  protected
  
  def save!
    key = "ticket:#{@ticket_id}:locked_by"
    value = @user_id
    
    @r.set(key, value)
    @r.expire(key, EXPIRE_TIME)
    # puts "Saved #{key}=#{value} expiring in #{EXPIRE_TIME}" 
  end
  
  
  # A Redis-backed model if one ticket is locked. Referenced by Tickets model in the form of Ticket.locked?

  # "ticket:134:locked" true 
  
end
