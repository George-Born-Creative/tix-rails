class Tix.Views.CartItemSmall extends Backbone.View
  template: JST['front/templates/cart/cart_item_small']
  
  events: 
    'click .close': 'close'
    
  close: ->
    TixLib.Dispatcher.trigger('closeCartItem', @model)
    @remove()
    
  initialize: ->
    
  render: ->
    @$el.html( @template( {seat: @model})  )
    
    @