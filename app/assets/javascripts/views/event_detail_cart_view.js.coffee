class Tix.Views.EventDetailCartView extends Backbone.View
  
  # this.collection is cartCollection
  
  initialize: ->
    _.bindAll this, 'onAddToCart', 'onRemoveFromCart'
    
    Tix.cart.bind 'add', @onAddToCart
    Tix.cart.bind 'remove', @onRemoveFromCart
    
    
    @$el = $('#event_detail_cart') # must be set here because it's created dynamically... todo: figure out why
    @$el.html('<ul></ul>')
    
    Tix.dispatcher.on 'area:click', (args)->
      ticket = Tix.tickets.filterByAreaId(args.area_id)[0]
      if !ticket
        console.log 'no ticket left!' # should not happen -- disable the button when inactive
      else
        Tix.cart.push ticket
        ticket.set('state', 'closed')
        # TODO: Fire event to let chart know to disable this area if no more tix left
    , this
        
    
    
  
  onAddToCart: ->
    cartItemView = new Tix.Views.EventDetailCartItemView( model: Tix.cart.last() )
    @$el.find('ul').prepend(cartItemView.render())
  
  onRemoveFromCart: (args)->
    #ticket = this.collection.get(ticket_id)
    #ticket.set('state', 'open')
    #this.collection.remove(ticket)