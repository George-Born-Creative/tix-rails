window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)

  Log: {
    i: (msg, obj)->
      console.log '*****' + msg + '*****'
      console.log obj
  }
  init: (data)->
    this.chart = new Tix.Models.SeatingChart(data.chart)
    this.cart = new Tix.Collections.Seats() # Seats added to cart
    this.availableSeats = new Tix.Collections.Seats() # Seats available to be added
    
    this.currentShow = new Tix.Models.Show(data.show)
    
    router = new Tix.Routers.MainRouter()
    Backbone.history.start()
    
    
$(document).ready ->
  #Tix.init()


# 1. Seating chart populated with seat drawing info and label, 
#    price. Loads (col)availableSeats with (model)Seats.

# 2. When seat dot clicked, add Seat to Cart collection

# 3. CartView is bound to Cart(Seats) collection.  CartView renders SeatView and TotalView