window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)
  
  init: (data)->
    this.chart = new Tix.Models.SeatingChart(data.chart)
    router = new Tix.Routers.MainRouter()
    Backbone.history.start()
    
    
$(document).ready ->
  #Tix.init()
