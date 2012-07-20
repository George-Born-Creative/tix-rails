class Tix.Views.EventDetailMiniView extends Backbone.View
  
  template: JST['event/event_detail_mini']
  
  initialize: ->
    @$el.addClass('col g16')
    
  render: ->
    html = @template( { event: @model } )
    @$el.html( html)
