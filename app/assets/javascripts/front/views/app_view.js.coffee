class Tix.Views.AppView extends Backbone.View
  el: $('body')
  
  initialize: ()->
    $('#logo').click ->
      Tix.router.navigate '#/'
    
    Tix.cart.on 'add', @updateTotal
    Tix.cart.on 'remove', @updateTotal

  
  updateTotal: ->
    total = Tix.cart.formattedTotals().total
    $('#header .info .cart_total').html(total)