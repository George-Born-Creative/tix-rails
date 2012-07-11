class Tix.Views.EventDetailCartView extends Backbone.View
  
  # this.collection is cartCollection
  
  initialize: ->
    _.bindAll this, 'onAddToCart', 'onRemoveFromCart', 'updateTotal'
    
    Tix.cart.bind 'add', @onAddToCart
    Tix.cart.bind 'remove', @onRemoveFromCart
    
    @subtotal = 0.00
    @serviceChargeTotal = 0.00
    @total = 0.00
    
    @$el = $('#event_detail_cart') # must be set here because it's created dynamically... todo: figure out why
    
    @$el.append('<ul></ul>')
    
    Tix.dispatcher.on 'area:click', (args)->
      ticket = Tix.tickets.filterByAreaId(args.area_id)[0]
      if !ticket
        #TODO: Show error 'no ticket left!'...  should not happen -- disable the button when inactive
      else
        Tix.cart.push ticket
        ticket.set('state', 'closed')
        # TODO: Fire event to let chart know to disable this area if no more tix left
    , this
        
  onAddToCart: (args)->
    cartItemView = new Tix.Views.EventDetailCartItemView( model: Tix.cart.last() )
    @$el.find('.intro').hide()
    @$el.find('ul').prepend(cartItemView.render())
    @updateTotal(args, 1)
    #TODO: Pusher
  
  onRemoveFromCart: (args)->
    #TODO: Pusher
    @updateTotal(args, -1)
    $.post('/')
    
  updateTotal: (item, op=1)-> # Expects either 1 or -1
    price = item.get('price')
    service_charge = item.get('service_charge')
    
    # Tix.log 'svc charge', service_charge
    
    @subtotal += price * op
    @serviceChargeTotal += service_charge * op
    @total = @subtotal + @serviceChargeTotal
    
    Tix.cart.trigger 'total:update',
      subtotal: @subtotal
      serviceChargeTotal: @serviceChargeTotal
      total: @total
      formattedServiceChargeTotal: Tix.utils.formatCurrency(@serviceChargeTotal)
      formattedSubtotal: Tix.utils.formatCurrency(@subtotal)
      formattedTotal: Tix.utils.formatCurrency(@total)