class Tix.Views.SeatSelectorView extends Backbone.View
  el: '#seat_chooser'

  initialize: ->
    @$el
      .find('ul li').first()
        .css('background-color', '#333')
        .html('Seat 1A')
    
  render: ->