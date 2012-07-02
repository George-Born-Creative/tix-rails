class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
    'buy/:show': 'show'
  
  initialize: (options)->
    appView = new Tix.Views.AppView()
    chartView = new Tix.Views.ChartView( model: Tix.chart)
    cartView = new Tix.Views.CartView( collection: Tix.cart)
    checkoutView = new Tix.Views.CheckoutView( collection: Tix.cart)
    mid_view = new Tix.Views.MidView( show: show)
    
    show = Tix.current_show
    
  index: ->

  show: ->
    $('#body').slideDown()