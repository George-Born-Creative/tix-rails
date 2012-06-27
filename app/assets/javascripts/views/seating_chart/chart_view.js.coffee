class Tix.Views.ChartView extends Backbone.View
  el: '#wrap'
    
  initialize: ->
    
    #_.bindAll @
    this.model.bind('change', this.render, this);
    @paper = Raphael('canvas', 403, 800)
    @render()
    Tix.dispatcher.on 'seat:click', -> console.log 'Seat Clicked'
    
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
      .click(this.seatClick)
      .data
        'origFill': '#aaa'
      .attr
        fill: '#aaa'
        'stroke-width': 0
        'stroke': 0
      .hover ->
        $('body').css('cursor', 'pointer')
        this.attr
          fill: '#ccc'
      , ->
        $('body').css('cursor', 'auto')
        this.attr
          fill: this.data('origFill')
        
  seatClick: (e) ->
    console.log this.data('label')
    Tix.dispatcher.trigger 'seat:click', this.data('label')
    
  drawPolySeats: ->