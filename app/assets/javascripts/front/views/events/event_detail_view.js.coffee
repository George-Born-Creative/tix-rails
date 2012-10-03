class Tix.Views.EventDetailView extends Backbone.View
  className: 'event_details'
  
  template: JST['front/templates/event/event_detail']
  
  initialize: ->
    _.bindAll this, 'render'
    # Tix.log 'This model in EventDetailView', this.model
    this.model.fetch()
    @model.bind 'change', @render, this
    
  render: ->
    @$el.html( @template ( @model )) 
    @