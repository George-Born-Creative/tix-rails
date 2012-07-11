class Tix.Views.EventDetailCheckoutView extends Backbone.View
  
  template: JST['event/event_detail_checkout']
  
  initialize: ->
    self = this
    @$el = $('#event_detail_checkout')
  
    @data = {
      formattedServiceChargeTotal: "$0.00"
      formattedSubtotal: "$0.00"
      formattedTotal: "$0.00"
    }
    
    @render()
    
    Tix.cart.on 'total:update', (args)->
      self.data = args
      self.render()
      
  render:->
    @$el.html( @template( @data )) 
    