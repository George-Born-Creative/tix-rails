class Tix.Views.EventDetailChartView extends Backbone.View

  template: JST['event/event_detail_chart']
  
  initialize: ->
    # Tix.log 'Initialize Tix.Views.EventDetailChartView'
    # Tix.log 'ChartData ', this.options.chartData
        
    @chartData = this.options.chartData
    @eventTicketsCollection = this.options.eventTicketsCollection
    # window.e = @eventTicketsCollection
    @chartElements = {} # map of area_ids to Raphael elements
    @chartColors = 
      active: '#ffffff'
      hover: '#ffff00'
      inactive: '#666666'
      
    window.Tix.chartColors = @chartColors # TODO: fix this. See this.areaHover/this.areaHoveroff
    
    @paper = Raphael('canvas', '100%', 800)
    
    self = this
    
    Tix.dispatcher.on 'cart:remove', (options)->
      ticket_id = options.ticket_id
      ticket = self.eventTicketsCollection.get(ticket_id)
      area_id = ticket.get('area_id')
      self.enableArea(area_id)
      #Tix.log 'Ticket from ChartView cart remove', ticket
      
  render: ->
    self = this
    
    @setBackgroundImage()
    @drawChart()
    @enableActiveAreas()
    @handleClicks()
    
  handleClicks: ->
    Tix.dispatcher.on 'area:click', (options)->
      area_id = options.area_id
      # console.log @eventTicketsCollection
      if 1 == @eventTicketsCollection.filterByAreaId(area_id).length
        # No more tickets!
        @disableArea(area_id)
    , this
    
  enableActiveAreas: ->
    self = this
    @eventTicketsCollection.forEach (tix, idx)->
      state = tix.get('state')
      if state == 'open'
        area_id = tix.get('area_id')
        @enableArea(area_id)
    , this
      
  disableArea: (area_id)->
    self = this
    element = @chartElements[area_id]
    
    if element.data('status') == 'open'
      element.data('status', 'closed')
    element.unclick @dispatchAreaClick
    element.unhover @areaHover, @areaHoveroff
    
    element.attr
      fill: @chartColors.inactive
      opacity: 0.5
    
    
      
    
  enableArea: (area_id)->
    self = this
    element = @chartElements[area_id]
    
    if element.data('status') == 'closed'
      # console.log @chartElements
      element.data('status', 'open')
      element.data('area_id', area_id)
      
      element.click @dispatchAreaClick
      
      element
        .attr
          opacity: 0.7
          fill: @chartColors.active
        .hover self.areaHover, self.areaHoveroff
        
         

  areaHover: (e)->
    self = this
    this.attr
      opacity: 0.9
      fill: Tix.chartColors.hover
      
  areaHoveroff: (e)->
    self = this
    this.attr
      opacity: 0.7
      fill: Tix.chartColors.active

  dispatchAreaClick: ->
    Tix.dispatcher.trigger 'area:click', { area_id: this.data('area_id') }
    
  drawChart: ->
    self = this
    _.each @chartData.areas, (area,idx)->
      switch area.type
        when 'single'
          elem = self.paper.circle(area.x, area.y, 6)
            .attr
              fill: @chartColors.inactive
              opacity: 0.5
              'stroke-width': 0
   
         when 'area'
           elem = self.paper.path(area.polypath)
             .attr
               fill: @chartColors.inactive
               opacity: 0.5
      elem.data('status', 'closed')
               
      @chartElements[area.id] = elem
    , this
    
    # Tix.log 'Chart elements', @chartElements
               
  setBackgroundImage: ->
    $('#wrap').css
      'background-image': 'url(' + @chartData.background_image_url + ')'