class Tix.Views.EventListView extends Backbone.View
  tagName: 'div'
  
  template: JST['event/event_list']
  
  render: ->

    @$el.html( @template( @model.attributes ))

    