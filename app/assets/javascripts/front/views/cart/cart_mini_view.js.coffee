class Tix.Views.CartMiniView extends Backbone.View
  el: $('.cart-mini')
  
  initialize: ->
    console.log 'Initialized Tix.Views.CartMiniView'
    @model = Tix.Cart
    console.log  "Tix.Views.CartMiniView initialized"
    @render()
    
  render: ->
    @$el.find('.cart-total').text(@model.total)
    @