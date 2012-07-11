class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
    'event/:id': 'eventById'
  
  initialize: (events)->
    @events = events
    @eventsView = new Tix.Views.EventsListView( collection: @events)
    @appView = new Tix.Views.AppView()
    _.bindAll this, 'index'
    
  index: ->
    @eventsView.$el.show()
    $('#sidenav').show()
    $('#mid').fadeIn('fast')

  eventById: (id)->    
    @eventsView.$el.fadeOut('fast')
    $('#sidenav').fadeOut('fast')
    event = new Tix.Models.Event({id: id})
    eventDetailView = new Tix.Views.EventDetailView(model: event)   
    
  
