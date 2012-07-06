class Tix.Views.EventDetailCartItemView extends Backbone.View
  tagName: 'li'
  
  template: JST['event/event_detail_cart_item']
  
  initialize: ->
    _.bindAll this, 'render'
    this.model.bind 'change', @render
    
  render: ->
    # Tix.log 'Tix.Views.EventDetailCartItemView html', @$el.html()
    @$el.html(@template(@model) )
