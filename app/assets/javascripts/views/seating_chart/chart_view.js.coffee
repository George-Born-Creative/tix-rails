class Tix.Views.ChartView extends Backbone.View
  el: '#wrap'
  
  initialize: ->
    
    @paper = Raphael('canvas', '100%', 800)
    @respondToSeatClick()
    @fillColor = '#000'
    @hotColor = '#E01E96'
    
    @setupModal()
    @view = this
    @modalDispatched = false
  
    _.bindAll this, 'drawSingleSeats', 'seatMouseover', 'seatMouseout'
    
    @render()
    
  render: ->
    @drawSingleSeats()   
    @drawAreaSeats()   
    
    @setBackgroundImage()
    
  setBackgroundImage: ->
    @$el.css
      'background-image': 'url(' + @model.attributes.background_image_url + ')'
  

    
  drawSingleSeats: ->
    self = this
    # console.log this.paper
    seats = @paper.set()
    singleSeats = @model.attributes.single_seats



    $.each singleSeats, (index, item)->
      x = item.x
      y = item.y
      r = 7
      seat = self.paper.circle(x, y, r)
      
      
      seat_model = new Tix.Models.Seat({
        label: item.label
        price: item.default_price
        status: 'available'
        type: 'single'
      })
      
      seat.data('model_cid', seat_model.cid)
      seat.click(self.dispatchSeatClick)
      
      seats.push seat
      
      Tix.availableSeats.push seat_model
      
      
      
    seats
      .data
        'origFill': '#ddd' #@fillColor
      .attr
        fill: '#ddd' #@fillColor
        'stroke-width': 0
        'stroke': 0
      .hover# @seatMouseover, @seatMouseout
    
    @paper.setFinish()
  
  drawAreaSeats: ->
    self = this
    # console.log this.paper
    seats = @paper.set()
    areaSeats = @model.attributes.area_seats
    
    
    $.each areaSeats, (index, item)->
      
      poly = self.paper.path(item.polypath)
      poly.data('label', item.label)
      poly.data('default_price', item.default_price)
      
      poly.click(  self.dispatchSeatClick )
      
      seat_model = new Tix.Models.Seat({
        label: item.label
        price: item.default_price
        status: 'available'     
        type: 'area'
           
      })
      
      poly.data('model_cid', seat_model.cid)
      
      
      poly
       .hover(@seatMouseover, @seatMouseout)
       .attr
         fill: '#E01E96'
         opacity: '0.2'
       .hover ->
         $('body').css('cursor', 'pointer')
         this.attr
           opacity: '0.5'
       , ->
         $('body').css('cursor', 'auto')
         this.attr
           opacity: '0.2'
        
      seats.push(poly)
      Tix.availableSeats.push seat_model
      
      
    @paper.setFinish()
    
    
        
         
  setupModal: ->
    md = @paper.rect(30, 10, 100, 50, 5)
    md
      .attr
        fill: '#222'
      .text
    t = @paper.text 120, 200, "Hi!"
    t
      .attr
        fill: '#fff'
        width: 100
      
        
    modal = new @paper.set()
    modal.push md
    modal.push t
    
    
    
    Tix.dispatcher.on 'seats:hidemodal', (args)->
      modal.attr('opacity', 0)
      
    Tix.dispatcher.on 'seats:showmodal', (args)->
      modal.attr('opacity', 1)
      modal.attr('x', args.x - 90)
      modal.attr('y', args.y - 60)
      
    Tix.dispatcher.trigger 'seats:hidemodal'

  
      
  seatMouseover: ->
    $('body').css('cursor', 'pointer')
    x = this.attr ('cx')
    y = this.attr( 'cy')
    
    this.attr 
      fill: '#000'
    
    Tix.dispatcher.trigger 'seats:showmodal', { text: 'Hi kids!', x: x, y:  y}
    
      
    
  seatMouseout: ->
    $('body').css('cursor', 'auto')
    
    this.attr
      fill: this.data('origFill')
      
    Tix.dispatcher.trigger 'seats:hidemodal'
  

  respondToSeatClick: ->
    self = this
    Tix.dispatcher.on 'seat:click', (element)->
      # console.log 'seat:click captured'
      element
        .attr
          fill: '#E01E96'
      
      
      cid = element.data('model_cid')
      model = Tix.availableSeats.getByCid(cid)
      model.set('status', 'unavailable')
      
      if model.get('type') == 'single'
        element.unclick(  self.dispatchSeatClick )
      
      Tix.cart.push model
      
      
        
      
  dispatchSeatClick: (e) ->  
    # console.log 'Dispatch seat click' 
    Tix.dispatcher.trigger 'seat:click', this
    
  drawPolySeats: ->

  
