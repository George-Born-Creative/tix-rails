class Tix.Routers.FrontChartRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    
  initialize: (data)->
    console.log "new Tix.Routers.FrontChartRouter() initialized"
    
    @event_starts_at = data.chart.event_starts_at
    @event_name = data.chart.event_name
    
    @chart = new Backbone.NestedModel(Tix.Chart)
    
    @listenForClicks()
    # @setupCart()
    @setupTotals()
    
    @inventoryByAreaID = @setupInventories(@chart)
    # console.log 'Inventory by area id'
    
    # console.log @inventoryByAreaID
    
    @chartView = new TixLib.Views.ChartRenderView({chart: @chart })
    
    _.templateSettings = 
      interpolate : /\{\{(.+?)\}\}/g
      
  setupInventories: (chart)-> # accept chart. return hash of area_id => 
    self = this
    sections = chart.get('sections')
    _inventoryByAreaID = {}
    _.each sections, (section)->
      if section.seatable
        _.each section.areas, (area)->
          _inventoryByAreaID[area.id] = area.inventory
    
    return _inventoryByAreaID
    
    
    
  setupTotals: ->
    
    cartTotalsView = new Tix.Views.CartTotalsView()
    $('#cart_totals_container').append(cartTotalsView.render().el)
    
    Tix.Cart.on('add', -> cartTotalsView.render() )
    Tix.Cart.on('remove', -> cartTotalsView.render() )
    
  
  
  # TODO: This is a messy system that may not survive future modification.
  # OK for now but should be refactored soon
  listenForClicks: ->
    self = this
    
    TixLib.Dispatcher.on 'closeCartItem', (seat)->
      console.log ["TixLib.Dispatcher.on 'closeCartItem'", seat]
      Tix.Cart.remove(seat)
    
    TixLib.Dispatcher.on 'areaClick', (data)-> 
      
      # console.log "Inventory is " + self.inventoryByAreaID[data.area.id]
      
      if self.inventoryByAreaID[data.area.id] > 0
      
        Tix.Cart.addSeat
          section: data.section
          area: data.area
          event:
            name: self.event_name
            starts_at: self.event_starts_at
            
            
      else
        self.chartView.disableArea(data.area.id)
      
      self.inventoryByAreaID[data.area.id] -= 1 # Reduce inventory by 1
      
      
      if self.inventoryByAreaID[data.area.id] == 0
        self.chartView.disableArea(data.area.id)
        
  
    Tix.Cart.on 'remove', (seat)->
      # console.log "Tix.Cart.on 'remove'"
      area_id = seat.get('area').id
      # console.log ['area_id', area_id]
      self.chartView.enableArea(area_id)
      self.inventoryByAreaID[area_id] += 1 # Increase inventory by 1
      
      
      # console.log '[SR] areaClick event received with data'
      # console.log data
      
