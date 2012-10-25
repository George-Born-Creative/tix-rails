class Tix.Views.CartMiniView extends Backbone.View
  el: $('.cart-mini')
  
  initialize: ->
    console.log 'Initialized Tix.Views.CartMiniView'
    @model = Tix.Cart
    console.log  "Tix.Views.CartMiniView initialized"
    @render()
    $('.cart-mini').show().fadeIn('fast')
    
    
  render: ->
    @$el.find('.cart-total').text(@model.total)
    @