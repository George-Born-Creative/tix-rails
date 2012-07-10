class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
    'event/:id': 'event_by_id'
  
  initialize: (events)->
    @events = events
    @eventsView = new Tix.Views.EventsListView( collection: @events)
    @appView = new Tix.Views.AppView()
    
    _.bindAll this, 'index'
    
  index: ->
    @eventsView.$el.show()
    $('#sidenav').show()
    $('#mid').fadeIn('fast')

  event_by_id: (id)->    
    @eventsView.$el.fadeOut('fast')
    $('#sidenav').fadeOut('fast')
    event = new Tix.Models.Event({id: id})
    eventDetailView = new Tix.Views.EventDetailView(model: event)   
    
