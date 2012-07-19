class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Ticket
  
  initialize: ->
    this.bind 'add', @onAddToCart
    this.bind 'remove', @onRemoveFromCart

    @totals = {
      subtotal: 0.00
      serviceChargeTotal: 0.00
      total: 0.00
    }
    
    _.bindAll this, 'updateTotal'
    
  formattedTotals: ->
    _fTotals = {}
    
    # console.log @totals
    _.each (_.keys @totals), (key)->
      _fTotals[key] = Tix.utils.formatCurrency(@totals[key])
    , this
    
    return _fTotals

  onAddToCart: (ticket)->
    ticket.startTimer()
    ticket_id = ticket.get('id')
    event_id = ticket.get('event_id')
    
    ticket.set('status', 'closed')
    
    Tix.ExternalEvents.lockTicket(ticket_id, event_id)
    
    @updateTotal(ticket, 1)

    
  onRemoveFromCart: (ticket)->
    ticket.resetTimer()
    ticket_id = ticket.get('id')
    if ticket_id
      Tix.ExternalEvents.unlockTicket(ticket_id)
    
    @updateTotal(ticket, -1)
    
    
    
  updateTotal: (ticket, op=1)-> # Expects either 1 or -1 as direction of addition
    # console.log 'updateTotal called'
    price = parseFloat ticket.get('price')
    service_charge = parseFloat ticket.get('service_charge')

    @totals.subtotal += price * op
    @totals.serviceChargeTotal += service_charge * op
    @totals.total = @totals.subtotal + @totals.subtotal
    # console.log [@totals]
    

    