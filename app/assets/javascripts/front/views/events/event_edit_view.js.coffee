class Tix.Views.EventEditView extends Backbone.View
  
  template: JST['front/templates/event/event_edit']
  
  initialize: ->
    console.log @model.attributes
    
  render: ->
    @$el.html @template( {event: @model} )
    @initEditables()
    @
    
  initEditables: ->
    @$el.find('.e')
      .attr('contentEditable', 'true')
      .css
        border: '1px solid #777'
        marginBottom: '10px'
        padding: '4px'
  