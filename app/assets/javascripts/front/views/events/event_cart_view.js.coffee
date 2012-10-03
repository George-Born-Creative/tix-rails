class Tix.Views.EventCartView extends Backbone.View
  
  # this.collection is cartCollection
  
  className: 'event_cart'
  tagName: 'ul'
  
  initialize: ->
    _.bindAll this, 'onAddToCart', 'onRemoveFromCart'
    @$el.addClass('col g4')
    
    Tix.cart.bind 'add', @onAddToCart
    Tix.cart.bind 'remove', @onRemoveFromCart
      
    
    @ticketViewById = {}
    
    # console.log 'initialize event cart view'
    
    self = this
    
    # @currentEvent = this.options.currentEvent
    
    _.each Tix.cart.models, (ticket) -> self.appendTicketView(ticket)
      
  render: ->
    @
    
  leave: ->
    @removeTicketViews
    this.remove()
    _.each _.values(@ticketViewById), (view)->
      view.leave() if view.leave
      view.remove() if view.remove
        
      
    
  removeTicketViews: ->
    
    
  onAddToCart: (ticket)->
    @appendTicketView(ticket)
    
    # console.log 'On Add to Cart'
    
  appendTicketView: (ticket)->
    cartItemView = new Tix.Views.EventCartItemView( model: ticket )
    
    id = ticket.get('id')
    @ticketViewById[id] = cartItemView
    @$el.prepend(cartItemView.render().el)
  
  onRemoveFromCart: (ticket)->
    id = ticket.get('id')
    if @ticketViewById[id]
      @ticketViewById[id].remove()
    
