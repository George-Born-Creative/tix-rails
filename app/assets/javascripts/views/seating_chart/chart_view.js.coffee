class Tix.Views.ChartView extends Backbone.View
  el: '#wrap'
    
  initialize: ->
    
    #_.bindAll @
    this.model.bind('change', this.render, this);
    @paper = Raphael('canvas', 403, 800)
    @render()
    @respondToSeatClick()
    
  render: ->
    @drawSingleSeats()   
    @setBackgroundImage()
    
  setBackgroundImage: ->
    @$el.css
      'background-image': 'url(' + @model.attributes.background_image_url + ')'
    
  drawSingleSeats: ->
    self = this
    seats = @paper.set()
    singleSeats = @model.attributes.single_seats

    $.each singleSeats, (index, item)->
      x = item.x
      y = item.y
      r = 5
      seat = self.paper.circle(x, y, r)
      seat.data('label', item.label)
      seats.push seat
      
    seats
      .click(this.dispatchSeatClick)
      .data
        'origFill': '#aaa'
      .attr
        fill: '#aaa'
        'stroke-width': 0
        'stroke': 0
      .hover @seatMouseover, @seatMouseout
      
  seatMouseover: ->
    $('body').css('cursor', 'pointer')
    this.attr
      fill: '#ccc'
    
  seatMouseOut: ->
    $('body').css('cursor', 'auto')
    this.attr
      fill: this.data('origFill')
          
  respondToSeatClick: ->
    Tix.dispatcher.on 'seat:click', (element)->
      element
        .attr
          fill: '#39f'
        .unhover @seatMouseover, @seatMouseout
        
      
  dispatchSeatClick: (e) ->
    Tix.dispatcher.trigger 'seat:click', this
    
  drawPolySeats: ->