class Tix.Views.EventDetailView extends Backbone.View
  
  el: $('#event_detail')
  
  template: JST['event/event_detail']
  
  initialize: ->
    _.bindAll this, 'render'
    @model.bind 'change', @render, this
    @model.fetch()
    
    
  render: ->    
    @tickets = new Tix.Collections.Tickets( this.model.get('tickets') )    
    @cart = new Tix.Collections.Cart() # Empty: represents cart
    @chart = new Tix.Models.Chart( this.model.get('chart') )
    @areas = new Tix.Collections.Areas(this.model.attributes.chart.areas )
    
    data_hash = {tickets: @tickets, cart: @cart, chart: @chart, areas: @areas}
    
    _.extend Tix, data_hash    
    
    @$el.html( @template( @model.attributes ) )
        
    chartView = new Tix.Views.EventDetailChartView(  )
    chartView.render()
    cartView = new Tix.Views.EventDetailCartView(  )
    cartView.render()
    checkoutView = new Tix.Views.EventDetailCheckoutView(  )
    checkoutView.render()
    
    # Using Tix.(object) for now for conciseness. Maybe pass data_hash to views and let them access via this.options