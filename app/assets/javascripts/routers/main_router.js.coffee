class Tix.Routers.MainRouter extends Backbone.Router
  routes: 
    '': 'index'
  
  initialize: (options)->
    v = new Tix.Views.ChartView( model: Tix.chart)
    v = new Tix.Views.SeatSelectorView( model: Tix.chart)
    
    
  index: ->
