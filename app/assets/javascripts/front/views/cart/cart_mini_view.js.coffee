class Tix.Views.CartMiniView extends Backbone.View
  el: $('.cart-mini')
  
  initialize: ->
    @model = Tix.Cart
    console.log  "Tix.Views.CartMiniView initialized"
    @render()
    
  render: ->
    @$el.find('.cart-total').text(@model.total)
    @