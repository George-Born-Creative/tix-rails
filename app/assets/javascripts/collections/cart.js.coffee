class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Ticket
  
  initialize: ->
    this.bind 'add', @onAddToCart
    this.bind 'remove', @onRemoveFromCart
    
    
  onAddToCart: (ticket)->
    ticket.startTimer()

    
  onRemoveFromCart: (ticket)->
    ticket.resetTimer()
