class Tix.Routers.MainRouter extends Support.SwappingRouter
  
  initialize: (events_data)->
    @$el = @el = $('#modules')
    
    @events = new Tix.Collections.Events( events_data )    
    @artists = new Tix.Collections.Artists()
    
    
    Tix.tickets = {}
    Tix.cart = new Tix.Collections.Cart()
    
    @appView = new Tix.Views.AppView()
    
    _.bindAll this, 'index', 'eventsList', 'ticketsById', 'eventDetailsById', 'artistDetailsById'
  
  routes: 
    '': 'index'
    'event': 'eventsList'
    'event/:id': 'eventDetailsById'
    'event/:id/edit': 'eventEditById'
    'tickets/:id': 'ticketsById'
    'artists': 'artistsList'
    'artists/:id': 'artistDetailsById'
    'artist/:id': 'artistDetailsById'
    'checkout': 'checkout'
    # Pages
    'lobby_bar': 'lobbyBar'
    'contact': 'contact'
    
    
  lobbyBar: ->
    @showLoading()
    view = new Tix.Views.PageView('page/lobby_bar')
    @swap view
    
  contact: ->
    @showLoading()
    view = new Tix.Views.PageView('page/contact')
    @swap view
    
  index: ->
    @showLoading()
    view = new Tix.Views.HomeView()
    @swap view
  
  eventsList: ->
    @showLoading()
    view = new Tix.Views.EventsListView( collection: @events)
    @swap view

  ticketsById: (id)->
    @showLoading()    
    event = @events.get(id)
    self = this
    
    
    # Delegates to jqXHR
    # http://backbonejs.org/#Model-fetch
    
    event.fetch({
      success: ->
        view = new Tix.Views.EventTicketsCompositeView( model: event )      
        self.swap( view)
        event.off()
    })
    
    
      

  eventDetailsById: (id)->
    @showLoading()
    event = @events.get(id)
    self = this
    
    # Delegates to jqXHR
    # http://backbonejs.org/#Model-fetch
    
    event.fetch({
      success: ->
        self.hideLoading()
        view = new Tix.Views.EventDetailView( model: event )
        self.swap( view)
    })
      
      
  eventEditById: (id)->
    @showLoading()
    event = @events.get(id)
    self = this
    event.fetch({
      success: ->
        self.hideLoading()
        view = new Tix.Views.EventEditView( model: event )
        self.swap( view)
    })
        
  artistsList: ->
    @showLoading()
    
    self = this
    @artists.fetch({
    success: ->
      view = new Tix.Views.ArtistsListView( collection: self.artists )
      self.swap( view)
    })
    
    
    
  artistDetailsById: (id)->
    @showLoading()
    self = this
    artist = new Tix.Models.Artist({id: id})
    
    artist.fetch({
      success: ->
        view = new Tix.Views.ArtistDetailiew( model: artist )
        self.swap( view)
    })
  
  
  checkout: ->
    @showLoading()
    self = this
    view = new Tix.Views.CheckoutView()
    self.swap( view)
  
  showLoading: ->
    @$el.empty()
    $('<img>')
      .attr('src', '/images/loading.gif')
      .css('text-align', 'center')
      .addClass('loading')
      .appendTo(@$el)
        
  hideLoading: ->
    @$el.empty()
    
    
    
    