class Tix.Views.CheckoutView extends Backbone.View
  template: JST['front/templates/checkout/checkout']
  
  initialize: ->
    @eventCartView = new Tix.Views.EventCartView(currentEvent: @model ) 
    cartHTML = @eventCartView.render().el
    
    
  leave: ->
    @eventCartView.leave()
    @remove()
    
  render: ->
    @$el.html( @template({tickets: Tix.cart.models }) )
    
    @$el.find('.cart_view').append @eventCartView.el
    
    @