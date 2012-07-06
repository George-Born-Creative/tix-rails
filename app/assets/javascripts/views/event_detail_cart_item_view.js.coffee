class Tix.Views.EventDetailCartItemView extends Backbone.View
  tagName: 'li'
  
  template: JST['event/event_detail_cart_item']
  
  events: {
    'click .close a': 'cancelTicket'
  }
  
  initialize: ->
    _.bindAll this, 'render'
    this.model.bind 'change', @render
    
  render: ->
    # Tix.log 'Tix.Views.EventDetailCartItemView html', @$el.html()
    @$el.html(@template(@model) )

  cancelTicket: ->
    Tix.dispatcher.trigger 'cart:remove', {ticket_id: this.model.id}
    
    this.remove()