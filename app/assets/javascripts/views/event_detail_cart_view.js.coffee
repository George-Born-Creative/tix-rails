class Tix.Views.EventDetailCartView extends Backbone.View
  
  # this.collection is cartCollection
  
  initialize: ->
    _.bindAll this, 'addToCart', 'removeFromCart'
    window.cart = this.collection
    @eventTicketsCollection = this.options.eventTicketsCollection
    
    this.collection.bind 'add', @addToCart
    
    @$el = $('#event_detail_cart') # must be set here because it's created dynamically... todo: figure out why
    @$el.html('<ul></ul>')
    
    Tix.dispatcher.on 'area:click', (args)->
      ticket = @eventTicketsCollection.filterByAreaId(args.area_id)[0]
      if !ticket
        console.log 'no ticket left!' # shoudl not happen -- disable the button when inactive
      else
        this.collection.push ticket
        ticket.set('state', 'closed')
        # TODO: Fire event to let chart know to disable this area if no more tix left
    , this
        
    
    Tix.dispatcher.on 'cart:remove', @removeFromCart
    
  
  addToCart: ->
    cartItemView = new Tix.Views.EventDetailCartItemView( model: this.collection.last() )
    # console.log cartItemView
    @$el.find('ul').prepend(cartItemView.render())
  
  
  removeFromCart: (args)->
    ticket_id = args.ticket_id
    ticket = this.collection.get(ticket_id)
    ticket.set('state', 'open')
    this.collection.remove(ticket)