class Tix.Views.CartTotalsSmallView extends Backbone.View
  el: $('#cart_totals')
  
  template: JST['front/templates/cart/cart_totals_small']
  
  initialize: ->
    
  render: ->
    # console.log 'Tix.Views.CartTotalsSmallView.render() '
    if typeof Tix.Cart != 'undefined'
      @$el.html( @template( { cart: Tix.Cart } ) )
    @