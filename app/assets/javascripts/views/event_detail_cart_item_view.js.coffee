class Tix.Views.EventDetailCartItemView extends Backbone.View
  tagName: 'li'
  
  template: JST['event/event_detail_cart_item']
  
  events:
    'click .close a': 'cancelTicket'
  
  initialize: ->
    _.bindAll this, 'render'
    this.model.bind 'change', @render
    self = this
    
    this.model.on 'tick', (d)->
      self.$el.find('.clock').html(d.time)
      
    this.model.on 'warning', (d)-> # 1 minute warning
      self.$el.css('background-color','rgba(255,0,0,.5)')
  
    this.model.on 'expire', (d)-> # 1 minute warning
      self.cancelTicket()
    
    
  render: ->
    # Tix.log 'Tix.Views.EventDetailCartItemView html', @$el.html()
    @$el.html(@template(@model) )

  cancelTicket: ->
    # Tix.log 'Cancel ticket called for', this.model
    Tix.cart.remove(this.model)
    
    this.remove()