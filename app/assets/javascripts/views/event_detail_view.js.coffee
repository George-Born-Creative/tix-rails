class Tix.Views.EventDetailView extends Backbone.View
  
  el: $('#event_detail')
  
  template: JST['event/event_detail']
  
  initialize: ->
    _.bindAll this, 'render'
    @model.bind 'change', @render, this
    @model.fetch()
    
    
  render: ->    
    @eventTicketsCollection = new Tix.Collections.Tickets( this.model.get('tickets') )    
    @cartTicketsCollection = new Tix.Collections.Tickets()
    
    @$el.html( @template( @model.attributes ))
    
    # Chart Areas implemented as regular Javascript Object
    # as they will not have to interact with server.
    # Tickets are wrapped with a BackBone collection because
    # they will have to interact with server (lock, unlock, etc) 
    
    chartData = this.model.get('chart')
    
    chartView = new Tix.Views.EventDetailChartView( chartData: chartData, eventTicketsCollection: @eventTicketsCollection)
    chartView.render()
    cartView = new Tix.Views.EventDetailCartView( collection: @cartTicketsCollection, eventTicketsCollection: @eventTicketsCollection)
    cartView.render()
    