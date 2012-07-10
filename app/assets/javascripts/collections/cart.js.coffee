class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Ticket
  
  initialize: ->
    this.bind 'add', @onAddToCart
    
  onAddToCart: ->
    ticket = this.last()
    ticket.startTimer()
