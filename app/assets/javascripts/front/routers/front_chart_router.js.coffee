class Tix.Routers.FrontChartRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    
  initialize: (data)->
    console.log "new Tix.Routers.FrontChartRouter() initialized"    
    view = new TixLib.Views.ChartRenderView({chart: data.chart })

    @listenForClicks
    
  index: ->

  listenForClicks: ->
    TixLib.Dispatcher.on 'areaClick', (data)-> 
      console.log '[SR] areaClick event received with data'
      console.log data
