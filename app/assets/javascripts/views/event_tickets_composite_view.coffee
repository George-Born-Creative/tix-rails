class Tix.Views.EventTicketsCompositeView extends Support.CompositeView
  className: 'event_tickets'
  
  initialize: ->
    self = this
    @tickets = Tix.tickets[@model.get('id')] = new Tix.Collections.Tickets( @model.get('tickets') )
    @chart = new Tix.Models.Chart( @model.get('chart') )
    @areas = new Tix.Collections.Areas( @chart.get('areas') )
        
    
  render: (e)->
    @renderDetailMini()
    @renderChart()
    @renderCart()
    @renderCheckout()
    @
    
  renderDetailMini: ->
    @eventDetailMiniView = new Tix.Views.EventDetailMiniView(model: @model )
    @renderChild @eventDetailMiniView  
    $('#modules').append @eventDetailMiniView.el
    

  renderCart: ->
    @eventCartView = new Tix.Views.EventCartView(currentEvent: @model ) 
    @renderChild @eventCartView 
    $('#modules').append @eventCartView.el
    
  renderChart: ->
    @eventChartView = new Tix.Views.EventChartView( model: @model, chart: @chart, areas: @areas, tickets: @tickets )
    @renderChild @eventChartView 
    $('#modules').append @eventChartView.el
  
  
  renderCheckout: ->
    @eventCheckoutView = new Tix.Views.EventCheckoutView()
    @renderChild @eventCheckoutView
    $('#modules').append @eventCheckoutView.el
