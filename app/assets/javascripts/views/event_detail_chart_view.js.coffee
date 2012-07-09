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
    
    @setupTooltip()
    
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
    
    @tooltip.hide()
    
    Tix.tooltip = @tooltip
  
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
      console.log tix
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
    Tix.tooltip.hide()
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
      console.log price
      # console.log @chartElements
      element.data('status', 'open')
      element.data('area_id', area_id)
      element.data('seat_label', seat_label)
      element.data('area_label', area_label)
      element.data('price', '$' + parseFloat(price).toFixed(2).toString())
      
      
      
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
      offset = if e.clientX > 450 then 170 else 0
      seat_label = this.data 'seat_label'
      seat_label = if seat_label == '' then '' else seat_label + "\n"
      area_label = this.data 'area_label'
      price = this.data 'price'
      
      
      Tix.tooltip.attr
        x: e.clientX - 200 - offset
        y: e.clientY - 240
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
    _.each @chartData.areas, (area,idx)->
      switch area.type
        when 'single'
          elem = self.paper.circle(area.x, area.y, 5)
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