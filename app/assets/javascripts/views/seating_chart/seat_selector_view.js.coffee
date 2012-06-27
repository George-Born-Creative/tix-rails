class Tix.Views.SeatSelectorView extends Backbone.View
  el: '#seat_chooser'

  initialize: ->
    @counter = 0
    
        
    @respondToSeatClick()
  
    
  render: ->
    
  respondToSeatClick: ->
    self = this
    Tix.dispatcher.on 'seat:click', (args)->
      self.addToSeatList(args)
    
  addToSeatList: (args)->
    @$el
      .find('ul li').eq(@counter)
        .css('background-color', '#333')
        .html(args.data('label'))
        
    @counter++