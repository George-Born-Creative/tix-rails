class Tix.Views.EventDetailCheckoutView extends Backbone.View
  
  initialize: ->
    self = this
    @$el = $('#event_detail_checkout')

    Tix.cart.on 'total:update', (args)->
      self.$el.find('.total').html(args.formattedTotal)