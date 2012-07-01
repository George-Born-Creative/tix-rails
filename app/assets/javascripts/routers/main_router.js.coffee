class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
  
  initialize: (options)->
    appView = new Tix.Views.App()
    chartView = new Tix.Views.ChartView( model: Tix.chart)
    cartView = new Tix.Views.CartView( collection: Tix.cart)
    checkoutView = new Tix.Views.CheckoutView( collection: Tix.cart)
    mid_view = new Tix.Views.MidView( show: show)
    
    show = Tix.current_show
    
  index: ->
