window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)

  log: (msg, obj)->
    return; # stub function is default

  initTixLogger: ->
    Tix.log = (msg, obj=null)->
      console.log 'Tix : ' + msg
      if obj != null
        console.log obj
    
  utils: 
    formatCurrency: (price)->
      return '$' + parseFloat(price).toFixed(2).toString()
    
  init: (data)->
    this.events = new Tix.Collections.Events(data.events)
    this.router = new Tix.Routers.MainRouter(this.events)
    Tix.pusherAPIKey = data.pusherAPIKey
    Tix.ExternalEvents.init()
    if data.env == 'development'
      Tix.initLoggers()
      
    Backbone.history.start()
    
  initLoggers: ->
    Tix.ExternalEvents.initPusherLog()
    Tix.initTixLogger()
    
  ExternalEvents: 
    init: ->
      @pusher = new Pusher(Tix.pusherAPIKey)
      @respondToLockedTicket()
      @respondToUnlockedTicket()
      
    initPusherLog: ->
      window.Pusher.log = (message)->
        if (window.console && window.console.log) then window.console.log(message)
      
    lockTicket: (ticket_id)->
      $.post "/api/ticket_locks.json/new", { ticket_id: ticket_id }, (response)->
        if response.status == 'ok'
          return
        else if response.status == 'error'
          Tix.log "Error locking ticket:" + response.error
          
    unlockTicket: (ticket_id)->
      $.post "/api/ticket_locks.json/delete", { ticket_id: ticket_id }, (response)->
        if response.status == 'ok'
          return
        else if response.status == 'error'
          Tix.log "Error unlocking ticket:" + response.error
          
    
                 
    respondToLockedTicket: ->
      @channel = @pusher.subscribe 'tickets'
      
      # console.log 'respondToLockedTicket called'
      @channel.bind 'lock', (data)->
        ticket_id = data.ticket_id
        ticket = Tix.tickets.get(ticket_id)
        ticket.set('status', 'locked')
        # Tix.log 'Pusher received', 
        
        # console.log ticket
    
    respondToUnlockedTicket: ->      
      @channel = @pusher.subscribe 'tickets'
      
      @channel.bind 'unlock', (data)->
        window.d = data
        ticket_id = data.ticket_id

        ticket = Tix.tickets.get(ticket_id)

        if ticket.get('status') == 'locked'
          ticket.set('status', 'open')
          # Tix.log 'unlocking ticket', ticket
        else
          # Tix.log 'ticket is not locked', ticket
              
$(document).ready ->
  
  # App is initialized via bootstrapped data in html