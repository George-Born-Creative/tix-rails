class Tix.Views.EventDetailChartView extends Backbone.View

  # Should bind Rafaël.js Chart's state to Areas collection
  
  template: JST['event/event_detail_chart']
  
  initialize: ->
    # Tix.log 'Initialize Tix.Views.EventDetailChartView'
    # Tix.log 'ChartData ', this.options.chartData
    # window.e = @eventTicketsCollection
    self = this
    
    @chartElements = {} # map of area_ids to Raphael elements
    @chartColors = 
      active: '#ffffff'
      hover: '#ffff00'
      inactive: '#666666'
      
    Tix.tickets.bind 'change:status', (ticket)->
      new_status = ticket.get('status')
      area_id = ticket.get('area_id')
      # Tix.log 'Ticket changed: new status', new_status
      # Tix.log 'Ticket changed: new_status', new_status
      
      @disableAreaIfNoTixLeft(area_id, false)
    , this
      
    window.Tix.chartColors = @chartColors # TODO: fix this. See this.areaHover/this.areaHoveroff
    
    @paper = Raphael('canvas', '100%', 800)
    
    @setupTooltip()
    @setupCartRemove()
    self = this
    
      
  render: ->
    self = this
    
    @setBackgroundImage()
    @drawChart()
    @enableActiveAreas()
    @handleClicks()
  
  setupCartRemove: ()->
    self = this
    Tix.cart.on 'remove', (ticket)->
      area_id = ticket.get('area_id')
      self.enableArea(area_id)
      # Tix.log 'Ticket from ChartView cart remove', ticket
      
      
  setupTooltip: (displayText="Seat 80\nGENERAL ADMISSION\n$15.00")->
    @tooltip = @paper.set()
    rect = @paper.rect(0,0,140,50,5)
    text = @paper.text(70, 140, displayText)
    label = @paper.text(50, 140, "Click to reserve")
    
    text.toFront()
    
    rect.attr
      fill: 'white'
      opacity: 0.8
    text.translate(70,20)
    label.attr
      fill: '#666'
    
    label.translate(70,40)
    
    @tooltip.push(rect)
    @tooltip.push(text)
    @tooltip.push(label)
    
    @tooltip.components = {rect, text, label}
    @tooltip.ox = 0
    @tooltip.oy = 0
    @tooltip.hide()
    
    Tix.tooltip = @tooltip
  
  handleClicks: ->
    self = this
    Tix.dispatcher.on 'area:click', (options) ->
      area_id = options.area_id
      self.disableAreaIfNoTixLeft(area_id, true)
    , this
    
    
  disableAreaIfNoTixLeft: (area_id, beforeRemoval=true)->    
    numRemaining = if (beforeRemoval == true) then 1 else 0
    if numRemaining == Tix.tickets.filterByAreaId(area_id).length
      
      # No more tickets!
      @disableArea(area_id)
    
  enableActiveAreas: ->
    self = this
    Tix.tickets.forEach (tix, idx)->

      state = tix.get('status')
      if state == 'open'
        area_id = tix.get('area_id')
        area_label = tix.get('area_label')
        price = tix.get('price')
        area_type = tix.get('area_type')
        seat_label = if area_type == 'area' then '' else tix.get('label')
        
        @enableArea(area_id, area_label, seat_label, price)
    , this
      
  disableArea: (area_id)->
    self = this
    #Tix.tooltip.hide()
    element = @chartElements[area_id]
    if element.data('status') == 'open'
      element.data('status', 'closed')
    element.unclick @dispatchAreaClick
    element.unhover @areaHover, @areaHoveroff
    
    element.attr
      fill: @chartColors.inactive
      opacity: 0.5
    
  enableArea: (area_id, area_label='', seat_label = '', price=0.00 )->
    self = this
    element = @chartElements[area_id]
    
    if element.data('status') == 'closed'

      element.data('state', 'open')
      element.data('area_id', area_id)
      element.data('seat_label', seat_label)
      element.data('area_label', area_label)
      element.data('price', Tix.utils.formatCurrency(price))
      
      
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
      cursor: 'pointer'
    
    
    
    this.mousemove (e)->
      
      seat_label = this.data 'seat_label'
      seat_label = if seat_label == '' then '' else seat_label + "\n"
      area_label = this.data 'area_label'
      price = this.data 'price'
      
      offLeft = e.pageX  -  $('#wrap').offset().left + 10
      offTop  = e.pageY  - $('#wrap').offset().top - 50
      
      offLeft = if offLeft >= 250 then offLeft - 160 else offLeft
      
      # console.log [wo.left, wo.top, e.pageX, e.pageY, e.pageX-wo.left, e.pageY-wo.top]
      
      Tix.tooltip.attr
        x: offLeft
        y: offTop
        
      Tix.tooltip.components.text.attr
        text: seat_label + area_label + "\n" + price
    Tix.tooltip.show().toFront()
    
      
  
  areaHoveroff: (e)->
    self = this
    this.attr
      opacity: 0.7
      fill: Tix.chartColors.active
    
    Tix.tooltip.hide()
    this.unmousemove()

  dispatchAreaClick: ->
    Tix.dispatcher.trigger 'area:click', { area_id: this.data('area_id') }

  drawChart: ->
    self = this
    _.each Tix.areas.models, (area,idx)->
      switch area.get('type')
        when 'single'
          elem = self.paper.circle(area.get('x'), area.get('y'), 5)
            .attr
              fill: @chartColors.inactive
              opacity: 0.5
              'stroke-width': 0
   
         when 'area'
           elem = self.paper.path(area.get('polypath'))
             .attr
               fill: @chartColors.inactive
               opacity: 0.5
      elem.data('status', 'closed')
               
      @chartElements[area.id] = elem
    , this
    
    # Tix.log 'Chart elements', @chartElements
               
  setBackgroundImage: ->
    $('#wrap').css
      'background-image': 'url(' + Tix.chart.get('background_image_url') + '?1)'