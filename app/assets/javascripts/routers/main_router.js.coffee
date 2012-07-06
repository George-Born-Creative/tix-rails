class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
    'event/:id': 'event_by_id'
  
  initialize: (events)->
    @events = events
    @eventsView = new Tix.Views.EventsListView( collection: @events)
    
    @appView = new Tix.Views.AppView()
    
    # chartView = new Tix.Views.ChartView( model: Tix.chart)
    # cartView = new Tix.Views.CartView( collection: Tix.cart)
    # checkoutView = new Tix.Views.CheckoutView( collection: Tix.cart)
    # mid_view = new Tix.Views.MidView( show: show)
    
    #show = Tix.current_show
    
    _.bindAll this, 'index'
    
  index: ->
    @eventsView.$el.fadeIn('fast')
    $('#sidenav').fadeIn('fast')

  event_by_id: (id)->    
    @eventsView.$el.fadeOut('fast')
    $('#sidenav').fadeOut('fast')
    
    event = new Tix.Models.Event({id: id})
    eventDetailView = new Tix.Views.EventDetailView(model: event)   
    
