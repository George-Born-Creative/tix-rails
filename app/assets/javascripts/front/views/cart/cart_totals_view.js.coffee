class Tix.Views.CartTotalsView extends Backbone.View
  template: JST['front/templates/cart/cart_totals']
 
  render: ->
    @$el.html( @template({cart: Tix.Cart}) )
    @