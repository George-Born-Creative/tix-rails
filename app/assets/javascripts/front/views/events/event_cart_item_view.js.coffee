class Tix.Views.EventCartItemView extends Backbone.View
  tagName: 'li'
  
  template: JST['front/templates/event/event_cart_item']
  
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
    
    @currentEvent = this.options.event
    
  render: ->
    # Tix.log 'Tix.Views.EventDetailCartItemView html', @$el.html()
    @$el.html( @template( { ticket: @model, event: @currentEvent } ) )
    @

  cancelTicket: ->
    # Tix.log 'Cancel ticket called for', this.model
    Tix.cart.remove(this.model)
    
    this.remove()