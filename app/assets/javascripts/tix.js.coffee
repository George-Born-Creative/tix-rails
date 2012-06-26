window.Tix =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
    paper = Raphael('canvas', 403, 800)

    seats = paper.set()
    
    seatingChart = $.getJSON '/api/seating_charts/2.json', (data)->
      drawSingleSeats( data.single_seats)
    
    
    drawSingleSeats = (singleSeats)->
      $.each singleSeats, (index, item)->
        console.log item
        x = item.x
        y = item.y
        r = 5
        fill = '#dddddd'
        seats.push paper.circle(x, y, r)

        seats
          .attr
            fill: '#562e2e'
            'stroke-width': 0
            'stroke': 0
          .hover ->
            console.log this.id
            this.attr
              fill: 'red'
          , ->
            this.attr
              fill: '#562e2e'


$(document).ready ->
  Tix.init()
