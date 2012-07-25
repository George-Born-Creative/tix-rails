Tix.OrderProcessor = 
  init: ->
    Tix.Dispatcher.on 'purchase:click', ->
      
      if Tix.cart.length
        order = new Tix.Models.Order()
        console.log order
        order.save()