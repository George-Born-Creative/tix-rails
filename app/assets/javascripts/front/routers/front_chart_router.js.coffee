class Tix.Routers.FrontChartRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    
  initialize: (data)->
    console.log "new Tix.Routers.FrontChartRouter() initialized"
    
    @event_starts_at = data.chart.event_starts_at
    @event_name = data.chart.event_name
    
    chartView = new TixLib.Views.ChartRenderView({chart: Tix.Chart })
    
    @listenForClicks()
    @setupCart()

    _.templateSettings = 
      interpolate : /\{\{(.+?)\}\}/g
    
  index: ->

  setupCart: ->
    
    Tix.Cart.on 'add', (seat)->
      view = new Tix.Views.CartItemSmall({model: seat})
      console.log view.render()
      $('#cart_container').prepend(view.render().el)
      
    
      

  listenForClicks: ->
    self = this
    TixLib.Dispatcher.on 'areaClick', (data)-> 
      Tix.Cart.addSeat
        section: data.section
        area: data.area
        event:
          name: self.event_name
          starts_at: self.event_starts_at
      
      # console.log '[SR] areaClick event received with data'
      # console.log data
      
