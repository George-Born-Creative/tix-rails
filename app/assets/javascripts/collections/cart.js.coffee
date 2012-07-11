class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Ticket
  
  initialize: ->
    this.bind 'add', @onAddToCart
    this.bind 'remove', @onRemoveFromCart
    
    
  onAddToCart: (ticket)->
    ticket.startTimer()
    ticket_id = ticket.get('id')
    
    Tix.ExternalEvents.lockTicket(ticket_id)

    
  onRemoveFromCart: (ticket)->
    ticket.resetTimer()
    ticket_id = ticket.get('id')
    
    Tix.ExternalEvents.unlockTicket(ticket_id)
    # Fire removed event external
    
    
    