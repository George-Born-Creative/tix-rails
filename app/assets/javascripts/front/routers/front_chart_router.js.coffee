class Tix.Routers.FrontChartRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    
  initialize: (data)->
    console.log "new Tix.Routers.FrontChartRouter() initialized"
    
    @event_starts_at = data.chart.event_starts_at
    @event_name = data.chart.event_name
    
    @chart = new Backbone.NestedModel(Tix.Chart)
    
    @chartView = new TixLib.Views.ChartRenderView({chart: @chart })
    
    @listenForClicks()
    @setupCart()
    @setupTotals()
    
    _.templateSettings = 
      interpolate : /\{\{(.+?)\}\}/g
    
  index: ->

  setupCart: ->
    
    Tix.Cart.on 'add', (seat)->
      view = new Tix.Views.CartItemSmall({model: seat})
      $('#cart_container').prepend(view.render().el)
      
      
    
  setupTotals: ->
    
    cartTotalsView = new Tix.Views.CartTotalsView()
    $('#cart_totals_container').append(cartTotalsView.render().el)
    
    Tix.Cart.on('add', -> cartTotalsView.render() )
    Tix.Cart.on('remove', -> cartTotalsView.render() )
    
  
    
  listenForClicks: ->
    self = this
    TixLib.Dispatcher.on 'areaClick', (data)-> 
      Tix.Cart.addSeat
        section: data.section
        area: data.area
        event:
          name: self.event_name
          starts_at: self.event_starts_at
      
      if (data.area.inventory - 1) == 0
        self.chartView.disableArea(data.area.id)
        
  
    Tix.Cart.on 'remove', (seat)->
      console.log "Tix.Cart.on 'remove'"
      area_id = seat.get('area').id
      console.log ['area_id', area_id]
      self.chartView.enableArea(area_id)
      
      
      # console.log '[SR] areaClick event received with data'
      # console.log data
      
