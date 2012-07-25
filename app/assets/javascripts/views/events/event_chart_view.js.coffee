class Tix.Views.EventChartView extends Backbone.View

  template: JST['event/event_chart']
  
  el: document.createElement('div')
  
  #className: 'event_chart'
  #id: 'event_chart'

  initialize: ->
    @$el.addClass('col g7')
    
    # console.log 'EventChartView initialized'
    # @$el.html('<div id="wrap"><div id="canvas"></div></div>')
    

    @chart = this.options.chart
    @areas = this.options.areas
    @tickets = this.options.tickets
    
    @event = this.model
    
    @areaIdToRaphael = {}

    @chartColors = 
       active: '#ffffff'
       hover: '#ffff00'
       inactive: '#666666'
         
    @self = self = this
        
    _.bindAll this, 'drawChart', 'areaMouseMove' # 'areaHoverOn', 'areaHoverOff'

  
  render: ->
    @setup()
    @
    
  # Garbage collection : unbind events
  leave: -> 
    @unListenToCart()
    # console.log Tix.cart
    
    @$el.empty().remove()
    self = this
    
    # _.each @areaIdToRaphael, (area)->
    #   _.each area.events, (e)->
    #     e.unbind()
    
    @paper.remove()
    
    this.off()
    
    this.remove()
    
    # console.log 'leave called in eventChartView'
  
  setup: ->
    @setBackgroundImage()
    @drawPaper()
    @drawChart()
    @enableAreas()
    @setupTooltip()
    @listenToCart()
    
  enableAreas: ->
    self = this
    _.each @tickets.activeAreaIds(), (area_id)->
        this.enableArea(area_id)
    , this
      
  enableArea: (area_id)->
    
    area_id = parseInt(area_id)
    self = this
    elem = this.areaIdToRaphael[area_id]
    
    if elem.data('activated') != true
      elem.click self.areaClick
      elem.mousemove self.areaMouseMove
      elem.data('activated', true)
      elem
        .attr
          'fill': @chartColors.active
        .hover self.areaHoverOn, self.areaHoverOff
    
    
  disableArea: (area_id)->
    area_id = parseInt(area_id)
    
    self = this
    elem = this.areaIdToRaphael[area_id]
    elem.data('activated', false)
    
    # console.log ['areaIdToRaphael', area_id, this.areaIdToRaphael, this.areaIdToRaphael[area_id], elem]
    # console.log elem
    
    elem
      .attr
        'fill': @chartColors.inactive
      .unhover()
    elem
      .unclick()
    elem.unmousemove()
    
    Tix.tooltip.hide()
    
    _.each elem.events, (ev,idx)->
      ev.unbind()
    

  areaClick: ->
    area_id = this.data('area_id')
    event_id =  this.data('event_id')  

    ticket = Tix.tickets[event_id].filterByAreaId(area_id)[0]
    
    Tix.cart.push(ticket)
    
  areaHoverOn: ->
    element = this
    area_id = element.data('area_id')
    event_id = element.data('event_id')
    nextTicket = Tix.tickets[event_id].filterByAreaId( area_id)[0]
    
    # console.log [Tix.tooltip.currentHoverAreaId, area_id]
    if Tix.tooltip.currentHoverAreaId != area_id
      Tix.tooltip.resetText(nextTicket)
    
    Tix.tooltip.show()
      
  
  listenToCart: ->
    Tix.cart.on 'add', @updateArea, this
    Tix.cart.off 'remove', @updateArea, this
    
    Tix.cart.on 'add', @handleAddToCart, this
    Tix.cart.on 'remove', @handleRemoveFromCart, this
    
    Tix.tickets[this.model.get('id')].on 'change:status', this.updateArea, this
    
    # console.log ['listenToCart', Tix.cart]
    
  unListenToCart: ->
    Tix.cart.off 'add', @updateArea, this
    Tix.cart.off 'remove', @updateArea, this
    
    Tix.cart.off 'add', @handleAddToCart, this
    Tix.cart.off 'remove', @handleRemoveFromCart, this
  
    Tix.tickets[this.model.get('id')].off 'change:status', this.updateArea, this
  
    # console.log ['unListenToCart', Tix.cart, Tix.cart.length]
  

    
  handleRemoveFromCart: (ticket)->
      
    area_id = ticket.get('area_id')
    event_id = ticket.get('event_id')

    current_event_id = @model.get('id')
    
    if event_id == current_event_id
      this.enableArea(area_id, event_id)
  
    
  handleAddToCart: (ticket)->
    area_id = ticket.get('area_id')
    event_id = ticket.get('event_id')
    
    Tix.tooltip.currentHoverAreaId = 0
    nextTicket = Tix.tickets[event_id].filterByAreaId( area_id)[0]
    Tix.tooltip.hide()
    if nextTicket
      Tix.tooltip.resetText(nextTicket)
      Tix.tooltip.show()
    
      
    event_id = @model.get('id')

  updateArea: (ticket) ->
    
    area_id = ticket.get('area_id')
    event_id = ticket.get('event_id')
    
    # console.log 'updateArea called'
    
    if Tix.tickets[event_id] != undefined
      
      remaining_tickets = Tix.tickets[event_id].filterByAreaId( area_id)
    
      if remaining_tickets.length == 0
        this.disableArea(area_id)
      else
        this.enableArea(area_id)
        
      
        
  areaHoverOff: ->
    Tix.tooltip.hide()
    
  areaMouseMove: (e)->
    offLeft = e.pageX  -  this.$el.offset().left + 10
    offTop  = e.pageY  - this.$el.offset().top - 90
    
    offLeft = if offLeft >= 250 then offLeft - 200 else offLeft
    
    # console.log [wo.left, wo.top, e.pageX, e.pageY, e.pageX-wo.left, e.pageY-wo.top]
    
    Tix.tooltip.attr
      x: offLeft
      y: offTop
      
        
    @tooltip.show().toFront()
    
    
  drawChart: ->
    self = this
    event_id = @event.get('id')
    
    _.each @areas.models, (area,idx)->
      switch area.get('type')
        when 'single'
          elem = self.paper.circle(area.get('x'), area.get('y'), 6)
        when 'area'
          elem = self.paper.path(area.get('polypath'))
          
      elem.attr
        fill: self.chartColors.inactive
        'stroke-width': 0
        
      elem.data 'area_id', area.get('id')
      elem.data 'event_id', event_id
      
      self.mapAreaIdToRaphael( parseInt(area.get('id')) ,  elem)
      
        
  mapAreaIdToRaphael: (area_id, elem)->
    area_id = parseInt(area_id)
    @areaIdToRaphael[area_id] = elem
      
  drawPaper: ->
    @paper = Raphael(this.el, '100%', 800)
    
  
  setBackgroundImage: ->
    @$el.css
      'background-image': 'url(' + @chart.get('background_image_url') + '?1)'
      'background-position': '-1px 0'
      'background-repeat': 'no-repeat'
      
  setupTooltip: (displayText="Seat 80\nGENERAL ADMISSION\n$15.00")->
    @tooltip = @paper.set()
    rect = @paper.rect(0,0,200,70,5)
    text = @paper.text(100, 200, displayText)
    label = @paper.text(100, 200, "Click to reserve")

    text.toFront()

    rect.attr
      fill: 'white'
      opacity: 0.8
      
    text
      .translate(100,30)
    text.attr
      'font-size': '15px'
    
    label
      .translate(100,60)
    
    label.attr
      fill: '#666'
      'font-size': '15px'


    @tooltip.push(rect)
    @tooltip.push(text)
    @tooltip.push(label)

    @tooltip.components = {rect, text, label}
    @tooltip.ox = 0
    @tooltip.oy = 0
    @tooltip.hide()

    Tix.tooltip = @tooltip
    Tix.tooltip.currentHoverAreaId = 0
    
    Tix.tooltip.resetText = (ticket)->
      # console.log ['ticket in resetText', ticket]
      area_id = ticket.get 'area_id'
      data = 
        seat_label: ticket.get('label')
        area_label: ticket.get('area_label')
        price: ticket.get('formattedPrice')
      
      template = _.template "<%= seat_label %>\n<%= area_label %>\n<%= price %>", data
      Tix.tooltip.currentHoverAreaId = area_id
    
      Tix.tooltip.components.text.attr
        text: template