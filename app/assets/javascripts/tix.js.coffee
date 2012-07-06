window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)

  log: (msg, obj=null)->
    console.log '***** ' + msg + ' *'
    if obj != null
      console.log obj
    console.log '*******************'
    
  init: (data)->
    this.events = new Tix.Collections.Events(data.events)
    this.router = new Tix.Routers.MainRouter(this.events)
    Backbone.history.start()
    
    
$(document).ready ->
  #Tix.init()


# 1. Seating chart populated with seat drawing info and label, 
#    price. Loads (col)availableSeats with (model)Seats.

# 2. When seat dot clicked, add Seat to Cart collection

# 3. CartView is bound to Cart(Seats) collection.  CartView renders SeatView and TotalView