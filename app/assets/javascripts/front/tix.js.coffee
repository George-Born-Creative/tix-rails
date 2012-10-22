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
    Tix.Cart = new Tix.Collections.Cart()
    # 
    # cartMiniView = new Tix.Views.CartMiniView()
    # 
    # 
    if Tix.Chart
       new Tix.Routers.FrontChartRouter({chart:Tix.Chart})
    
    
