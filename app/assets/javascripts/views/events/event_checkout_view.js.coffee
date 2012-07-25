class Tix.Views.EventCheckoutView extends Backbone.View
  
  template: JST['event/event_checkout']
      
  initialize: ->
    self = this
    @$el.addClass('col g5')
      
    @updateTotals() # sets @data
    @render()
    
    Tix.cart.on 'add', @updateTotals, this
    Tix.cart.on 'remove', @updateTotals, this
    
    _.bindAll this, 'updateTotals'
    
  updateTotals: ->
    @data  = Tix.cart.formattedTotals()    
    @render()
      
  render:->
    @$el.html( @template( @data )) 
    
    