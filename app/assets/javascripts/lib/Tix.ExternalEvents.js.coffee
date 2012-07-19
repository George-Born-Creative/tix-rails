Tix.ExternalEvents = 
  init: ->
    @pusher = new Pusher(Tix.pusherAPIKey)
    @respondToLockedTicket()
    @respondToUnlockedTicket()
    
  initPusherLog: ->
    window.Pusher.log = (message)->
      if (window.console && window.console.log) then window.console.log(message)
    
  lockTicket: (ticket_id)-> # called from Cart collection
    $.post "/api/ticket_locks.json/new", { ticket_id: ticket_id }, (response)->
      if response.status == 'ok'
        return
      else if response.status == 'error'
        Tix.log "Error locking ticket:" + response.error
        
  unlockTicket: (ticket_id)-> # called from Cart collection
    $.post "/api/ticket_locks.json/delete", { ticket_id: ticket_id }, (response)->
      if response.status == 'ok'
        return
      else if response.status == 'error'
        Tix.log "Error unlocking ticket:" + response.error
        
  
               
  respondToLockedTicket: ->
    @channel = @pusher.subscribe 'tickets'
    
    # console.log 'respondToLockedTicket called'
    @channel.bind 'lock', (data)->
      # console.log data

      ticket_id = data.ticket_id
      event_id = data.event_id
      if Tix.tickets[event_id]
        ticket = Tix.tickets[event_id].get(ticket_id)
        if ticket
          ticket.set('status', 'locked')
          # console.log ['setting ticket to locked', ticket]
        
      # Tix.log 'Pusher received', 
      
      # console.log ticket
  
  respondToUnlockedTicket: ->      
    @channel = @pusher.subscribe 'tickets'
    
    @channel.bind 'unlock', (data)->
      ticket_id = data.ticket_id
      event_id = data.event_id
      
      # If tickets for this event area loaded, update its status
      
      if Tix.tickets[event_id] 
        ticket = Tix.tickets[event_id].get(ticket_id)
        if ticket
          if ticket.get('status') == 'locked'
            ticket.set('status', 'open')
            # Tix.log 'unlocking ticket', ticket
          else
            # Tix.log 'ticket is not locked', ticket
