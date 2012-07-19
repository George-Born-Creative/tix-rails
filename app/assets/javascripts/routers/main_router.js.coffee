class Tix.Routers.MainRouter extends Support.SwappingRouter
  
  initialize: (events_data)->
    @$el = @el = $('#modules')
    
    @events = new Tix.Collections.Events( events_data )    
    
    @appView = new Tix.Views.AppView()
    
    Tix.tickets = {}
    Tix.cart = new Tix.Collections.Cart()
    
    _.bindAll this, 'index', 'ticketsById', 'eventDetailsById'
  
  routes: 
    '': 'index'
    'event/:id': 'eventDetailsById'
    'tickets/:id': 'ticketsById'
    
  
  index: ->
    @showLoading()
    view = new Tix.Views.EventsListView( collection: @events)
    @swap view

  ticketsById: (id)->
    @showLoading()    
    event = @events.get(id)
    self = this
    
    event.on 'change', ->
      view = new Tix.Views.EventTicketsCompositeView( model: event )      
      self.swap view
      event.off()
    , this
    
    event.fetch()
      

  eventDetailsById: (id)->
    @showLoading()
    event = @events.get(id)
    self = this
    
    event.on 'change', ->      
      self.hideLoading()

      view = new Tix.Views.EventDetailView( model: event )
      self.swap view
      event.off()
    , this
    
    event.fetch()
    
  showLoading: ->
    @$el.empty()
    $('<img>')
      .attr('src', '/images/loading.gif')
      .css('text-align', 'center')
      .addClass('loading')
      .appendTo(@$el)
        
  hideLoading: ->
    @$el.empty()
    
    