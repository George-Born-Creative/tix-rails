class Tix.Models.Order extends Backbone.Model
  urlRoot: '/api/orders'
  
  initialize: ()->
    ticket_ids = _.map Tix.cart.models, (ticket)->
      return ticket.get('id')
    
    ticket_ids_flat = JSON.stringify(ticket_ids)
    this.set('ticket_ids_flat', ticket_ids_flat)
    
