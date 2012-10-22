window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  # Dispatcher: _.clone(Backbone.Events)
  
  utils: 
    formatCurrency: (price)->
      return '$' + parseFloat(price).toFixed(2).toString()
    
  init: (data)->
    console.log 'ThinTix App Initialized'
    
    @initCart()
    @initCartMiniView()
    @initChart()
    
  initCart: ->
    Tix.Cart = new Tix.Collections.Cart()
    
  initCartMiniView: ->
    
    cartMiniView = new Tix.Views.CartMiniView()
    Tix.Cart.on 'add', -> cartMiniView.render()
    Tix.Cart.on 'remove', -> cartMiniView.render()
    
  initChart: ->
    if Tix.Chart
      new Tix.Routers.FrontChartRouter({chart:Tix.Chart})
    