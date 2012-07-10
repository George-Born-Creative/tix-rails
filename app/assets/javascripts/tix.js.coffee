window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)

  


  log: (msg, obj=null)->
    console.log '***** ' + msg + ' *'
    if obj != null
      console.log obj
    console.log '*******************'
    
  utils: 
    formatCurrency: (price)->
      return '$' + parseFloat(price).toFixed(2).toString()
    
  init: (data)->
    this.events = new Tix.Collections.Events(data.events)
    this.router = new Tix.Routers.MainRouter(this.events)
    
    Backbone.history.start()
  
  config: 
    PusherAPIKey: '52fcd783b4f4c6cbf542'
    
  ExternalEvents: 
    init: ->
      @pusher = new Pusher('52fcd783b4f4c6cbf542')
      @respondToLockedTicket()
      
      #window.Pusher.log = (message)->
      #  if (window.console && window.console.log) then window.console.log(message)
      
    lockTicket: (ticket_id)->
      $.post "/api/ticket_locks.json/new", { ticket_id: ticket_id }, (response)->
        if response.status == 'ok'
          return
        else if response.status == 'error'
          Tix.log "Error locking ticket:" + response.error
                 
    respondToLockedTicket: ->
      # console.log 'respondToLockedTicket called'
      @channel = @pusher.subscribe 'tickets'
      @channel.bind 'lock', (data)->
        ticket_id = data.ticket_id
        ticket = Tix.tickets.get(ticket_id).set('status', 'locked')
        # Tix.log 'Pusher received', 
        
        # console.log ticket
    
    
$(document).ready ->
  Tix.ExternalEvents.init()
  # App is initialized via bootstrapped 