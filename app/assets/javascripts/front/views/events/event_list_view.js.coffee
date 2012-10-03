class Tix.Views.EventListView extends Backbone.View
  tagName: 'div'
  
  events:
    'click': 'eventClick'
  
  template: JST['front/templates/event/event_list']
  
  render: ->
    @$el.html( @template( @model.attributes ))
    @
  
  leave: ->
    this.off()
    this.remove()

  eventClick: ->
    Tix.router.navigate '#/event/' + this.model.id